#ifndef CHATCLIENT_H
#define CHATCLIENT_H
#include <QObject>
#include <QDebug>
#include <QString>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QtDBus>

#include "chat_adaptor.h"
#include "chat_interface.h"

class ChatClient:public QObject
{
    Q_OBJECT
public:
    ChatClient();
    Q_INVOKABLE void setNameofOwn(const QString& name);
    Q_INVOKABLE void setMessage(const QString& message);
    Q_INVOKABLE void sendMessage();

signals:
    void nameChanged           (const QString& name); // in proxy
    void receiveNameChanged    (const QString& name);
    void messageChanged         (const QString& name,const QString& message); // in proxy
    void receiveMessageChanged (const QString& name,const QString& message);

    void visibleSignal();
private:
    QString m_name;
    QString m_message;
    OrgDbusChatInterface *proxyui1;
};

#endif // CHATCLIENT_H
