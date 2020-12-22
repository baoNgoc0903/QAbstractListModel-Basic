#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QList>
int main(int argc, char *argv[]){
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *context1 = engine.rootContext();
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
