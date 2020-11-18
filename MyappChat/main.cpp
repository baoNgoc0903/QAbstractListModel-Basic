#include <QGuiApplication>
#include "chatclient.h"
#include <QList>
#include <QQuickItem>
#include <QPushButton>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    ChatClient cl;
    context->setContextProperty("nickname", &cl);

    engine.load(QUrl(QStringLiteral("qrc:/Nickname.qml")));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
