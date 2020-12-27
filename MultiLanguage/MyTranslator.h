#ifndef MYTRANSLATOR_H
#define MYTRANSLATOR_H
#include "MyLanguage.h"
#include <QDebug>
#include <QObject>
#include <QTranslator>
#include <QGuiApplication>

class MyTranslator: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString emptySting READ getEmptyString NOTIFY languageChanged)
public:
    MyTranslator(QGuiApplication *app){
        mApp = app;
    }
public:
    QString getEmptyString(){
        return "";
    }
signals:
    void languageChanged();
public slots:
    void updateLanguage(int lan){
        switch(lan){
        case MyLanguage::VN:{
            qDebug() << "vnvnvnvnvn";
            mTranslator.load("lg_vn", ":/mtranslator");
            mApp->installTranslator(&mTranslator);
            break;
        }
        default:{
            qDebug() << "egegegegegeg";
            mApp->removeTranslator(&mTranslator);
            break;
        }
            emit languageChanged();
        }
    }
private:
    QGuiApplication *mApp;
    QTranslator mTranslator;
};

#endif // MYTRANSLATOR_H
