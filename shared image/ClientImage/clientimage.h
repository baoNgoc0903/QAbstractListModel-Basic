#ifndef CLIENTIMAGE_H
#define CLIENTIMAGE_H

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
#include<string.h>
#include<QDebug>
#include<QQuickImageProvider>

class ClientImage : public QDialog, public QQuickImageProvider
{
    Q_OBJECT // k có thằng này thì Q_INVOKABLE vẫn is not a function ở chỗ property from C++ to qml
    QString m_filename;
    Q_PROPERTY(QString m_path READ getPath WRITE setPath NOTIFY pathChanged)

signals:
    void pathChanged();
public:
    ClientImage();
//    QString openImage();
    Q_INVOKABLE QString openImage();
    QString getPath();
    void setPath(QString filename);

    void mperror(char* msg){
        perror(msg);
        exit(1);
    }
public slots:
    void createClientSharedMem();
};

#endif // CLIENTIMAGE_H
