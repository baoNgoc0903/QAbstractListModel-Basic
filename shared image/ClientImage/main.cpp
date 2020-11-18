#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
#include<QApplication>
#include"clientimage.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    ClientImage cli_image;
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("m_cli_image", &cli_image);
    qDebug() <<"day la o ham main";
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
