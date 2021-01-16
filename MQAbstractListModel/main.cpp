#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "mclassmodel.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QQmlContext *context1 = engine.rootContext();
    MClassModel mclass;
    MStruct a,b;
    mclass.createMStruct(a, "09-03-1998", 23, "baongoc", true);
    mclass.addMStruct(a);
    mclass.createMStruct(b, "04-12-98", 22, "ngochai", false);
    mclass.addMStruct(b);
    context1->setContextProperty("mclass", &mclass);


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));



    return app.exec();
}
