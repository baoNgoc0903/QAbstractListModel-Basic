#include "serveimage.h"
#include<iostream>
ServeImage::ServeImage() : result("")
{
        //for semaphore
        union semun{
            int val;
            struct semid_ds *buf;
            ushort array[1];
        }sem_attr;

        //screate emaphore mutex_binary
        if((key = ftok(SEMAPHORE_MUTEX_BINARY_IMAGE, CHARLOCK))==-1)
            mperror("ftok fail");
        if((mutex_binary = semget(key, 1, 0666|IPC_CREAT)) ==-1)
            mperror("semget fail");
        sem_attr.val = 0;
        if(semctl(mutex_binary, 0, SETVAL, sem_attr) ==-1)
            mperror("semctl fail");

        // create shared memory
        if((key = ftok(SHARED_MEM_IMAGE, CHARLOCK)) ==-1)
            mperror("ftok fail");
        if((shm_id = shmget(key, sizeof(char*), 0666|IPC_CREAT))==-1)
            mperror("shmget fail");
        if((shared_mem_ptr = (char*)shmat(shm_id, NULL, 0)) ==(char*)(-1))
            mperror("shmat fail");

        //create semaphore goin vs semaphore print
        if((key = ftok(SEMAPHORE_MUTEX_GOIN_IMAGE, CHARLOCK))==-1)
            mperror("ftok fail");
        if((mutex_goin = semget(key, 1, 0666|IPC_CREAT)) ==-1)
            mperror("semget fail");
        sem_attr.val = 10;
        if(semctl(mutex_goin, 0, SETVAL, sem_attr) ==-1)
            mperror("semctl fail");
        //
        if((key = ftok(SEMAPHORE_MUTEX_PRINT_IMAGE, CHARLOCK))==-1)
            mperror("ftok fail");
        if((mutex_print = semget(key, 1, 0666|IPC_CREAT)) ==-1)
            mperror("semget fail");
        sem_attr.val = 0;
        if(semctl(mutex_print, 0, SETVAL, sem_attr) ==-1)
            mperror("semctl fail");
        //
        sem_attr.val = 1;
        if(semctl(mutex_binary, 0, SETVAL, sem_attr) ==-1)
            mperror("semctl fail");
}

void ServeImage::mperror(char *msg){
    perror(msg);
    exit(1);
}

void ServeImage::setPath(QString filename){

    struct sembuf asem[1];
    asem[0].sem_flg=0;
    asem[0].sem_op = 0;
    asem[0].sem_num=0;

    std::cout << "bat dau khoa:" << std::endl;
//            while(1){
    asem[0].sem_op = -1;
    if((semop(mutex_print, asem, 1)) ==-1)
        mperror("semop fail");

    printf("%s", shared_mem_ptr);
    filename = QString(QLatin1String(shared_mem_ptr));
    if(filename!= result){
        result = filename;
        emit pathChanged();
    }

    asem[0].sem_op = 1;
    if((semop(mutex_goin, asem,1))== -1)
        mperror("semop fail");
//            }

//     std::cout << "ket thuc khoa:" << std::endl;
//    filename = QString(QLatin1String(shared_mem_ptr));
//    if(filename!= result){
//        result = filename;
//        emit pathChanged();
//    }
}
