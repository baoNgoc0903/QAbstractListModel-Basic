#include "chatclient.h"
#include<QtDBus>
ChatClient::ChatClient(): m_name(""), m_message("")
{
    new ChatAdaptor(this);
    QDBusConnection connect = QDBusConnection::sessionBus();
    connect.registerObject("/", this);

    proxyui1 = new OrgDbusChatInterface(QString(), QString(),
                                          QDBusConnection::sessionBus(), this);

    QObject::connect(proxyui1, SIGNAL(nameChanged(const QString&)),
                     this, SIGNAL(receiveNameChanged(const QString&)));

    QObject::connect(proxyui1, SIGNAL(messageChanged(const QString&,const QString&)),
                     this, SIGNAL(receiveMessageChanged(const QString&,const QString&)));
}

void ChatClient::visibleSlot(){
    emit visibleSignal();
}

void ChatClient::setNameofOwn(const QString& name){
    m_name = name;
}

void ChatClient::setMessage(const QString &message){
    m_message = message;
}

void ChatClient::sendMessage(){
    emit messageChanged(m_name, m_message);
}

