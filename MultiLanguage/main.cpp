#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "MyLanguage.h"
#include "MyTranslator.h"
int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    MyTranslator mTrans(&app);
    context->setContextProperty("mytrans", &mTrans);
    qmlRegisterType<MyLanguage>("MyLanguage", 1, 0, "MyLanguage");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.load(QUrl(QStringLiteral("qrc:/MTest.qml")));

    return app.exec();
}
