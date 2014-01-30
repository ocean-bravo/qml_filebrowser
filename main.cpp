#include <QGuiApplication>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "DriveList.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    DriveList driveList;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("DriveList", &driveList);
    engine.load(QUrl("qrc:///qml/main.qml"));

    return app.exec();
}
