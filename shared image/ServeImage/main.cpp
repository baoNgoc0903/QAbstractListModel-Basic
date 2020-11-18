#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
#include<QApplication>
#include"serveimage.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    ServeImage ser_image;
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("m_ser_image", &ser_image);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
