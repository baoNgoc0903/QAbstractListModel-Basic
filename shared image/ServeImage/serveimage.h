#ifndef SERVEIMAGE_H
#define SERVEIMAGE_H

#define SEMAPHORE_MUTEX_BINARY_IMAGE "/tmp/mutex-binary-image"
#define SEMAPHORE_MUTEX_GOIN_IMAGE "/tmp/mutex-goin-image"
#define SEMAPHORE_MUTEX_PRINT_IMAGE "/tmp/mutex-print-image"
#define SHARED_MEM_IMAGE "/tmp/shared_mem_image"
#define CHARLOCK 'N'
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include<errno.h>
#include<stdio.h>
#include<QString>
#include<QFileDialog>
#include<QDebug>

class ServeImage : public QDialog
{
    //for semaphore and create shared mem
    key_t key;
    int mutex_binary, mutex_goin, mutex_print, shm_id;
    char* shared_mem_ptr;
    QString result; // path take from shared mem
    Q_OBJECT
    Q_PROPERTY(QString ser_path READ getPath WRITE setPath NOTIFY pathChanged)
signals:
    void pathChanged();
public:
    ServeImage();
    QString getPath(){
        return result;
    }
    void mperror(char* msg);
    void setPath(QString filename);
};

#endif // SERVEIMAGE_H
