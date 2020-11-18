#include "clientimage.h"
#include<iostream>

ClientImage::ClientImage() : m_filename(""), QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    QObject::connect(this, SIGNAL(pathChanged()), this, SLOT(createClientSharedMem()));
}

QString ClientImage::openImage(){
    QString filename;
    filename = QFileDialog::getOpenFileName(0, "*_*Open Image*_*", "/home/baongoc/LearnQML/Image","Image file(*.png *.xpm *.jpg)");
    return filename;
}

QString ClientImage::getPath()
{
    return m_filename;
}

void ClientImage::setPath(QString filename)
{
    if(filename!=m_filename){
        m_filename = filename;
        emit pathChanged();
    }
}

void ClientImage::createClientSharedMem(){
    key_t key;
    int mutex_binary, mutex_goin, mutex_print, shm_id;
    char* shared_mem_ptr;
    //for semaphore
    union semun{
        int val;
        struct semid_ds *buf;
        ushort array[1];
    }sem_attr;

    //screate emaphore mutex_binary
    if((key = ftok(SEMAPHORE_MUTEX_BINARY_IMAGE, CHARLOCK))==-1)
        mperror("ftok fail");
    if((mutex_binary = semget(key, 1, 0666)) ==-1)
        mperror("semget fail");

    // create shared memory
    if((key = ftok(SHARED_MEM_IMAGE, CHARLOCK)) ==-1)
        mperror("ftok fail");
    if((shm_id = shmget(key, sizeof(char*), 0666))==-1)
        mperror("shmget fail");
    if((shared_mem_ptr = (char*)shmat(shm_id, NULL, 0)) ==(char*)(-1))
        mperror("shmat fail");

    //create semaphore goin vs semaphore print
    if((key = ftok(SEMAPHORE_MUTEX_GOIN_IMAGE, CHARLOCK))==-1)
        mperror("ftok fail");
    if((mutex_goin = semget(key, 1, 0666)) ==-1)
        mperror("semget fail");
    //
    if((key = ftok(SEMAPHORE_MUTEX_PRINT_IMAGE, CHARLOCK))==-1)
        mperror("ftok fail");
    if((mutex_print = semget(key, 1, 0666)) ==-1)
        mperror("semget fail");

    //for semop - operation Psem and Vsem
    struct sembuf asem[1];
    asem[0].sem_flg=0;
    asem[0].sem_op = 0;
    asem[0].sem_num=0;
    char *shared_copy;
//    while(1){
        asem[0].sem_op = -1;
        if((semop(mutex_goin, asem, 1)) ==-1)
            mperror("semop fail");

        asem[0].sem_op = -1;
        if(semop(mutex_binary, asem,1) ==-1)
            mperror("semop fail");

        QByteArray qarr = m_filename.toLatin1();
        shared_copy = qarr.data();
        strcpy(shared_mem_ptr, shared_copy);

        asem[0].sem_op = 1;
        if(semop(mutex_binary, asem,1) ==-1)
            mperror("semop fail");

        asem[0].sem_op = 1;
        if((semop(mutex_print, asem, 1)) ==-1)
            mperror("semop fail");
//    }
        std::cout << shared_mem_ptr << std::endl;
        std::cout <<"\nden day thi la chay oke" << std::endl;
        if (shmdt((void *) shared_mem_ptr) == -1)
                mperror("shmdt fail");
}
