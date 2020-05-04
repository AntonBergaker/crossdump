#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>
#include <QtQml>
#include "navigator.h"
#include "availableroutes.h"
#include "traveler.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // get the target setting from the .pro-file:
#if defined(TARGET_ARM_IMX5) || defined(TARGET_ARM_IMX6)
    bool targetARM = true;
#else
    // virtual machine
    bool targetARM = false;
#endif

    QQuickView *view = new QQuickView;
    QObject::connect(view->engine(), &QQmlEngine::quit, &app, &QGuiApplication::quit);

    // this will set the "targetARM" property to true if the software is built for ARM
    int displayWidth = 1280; int displayHeight = 800;

    qmlRegisterType<Navigator>("com.crossdump.navigator", 1, 0, "Navigator");
    qmlRegisterType<NavigationTask>("com.crossdump.navigationtask", 1, 0, "NavigationTask");
    qmlRegisterType<NavigationSegment>("com.crossdump.navigationsegment", 1, 0, "NavigationSegment");
    qmlRegisterType<Zone>("com.crossdump.zone", 1, 0, "Zone");
    qmlRegisterType<Route>("com.crossdump.route", 1, 0, "Route");
    qmlRegisterType<AvailableRoutes>("com.crossdump.availableroutes", 1, 0, "AvailableRoutes");
    qmlRegisterType<Traveler>("com.crossdump.traveler", 1, 0, "Traveler");

    qRegisterMetaType<QGeoRoute>("QGeoRoute");

    view->rootContext()->setContextProperty("targetARM", QVariant(targetARM));
    view->rootContext()->setContextProperty("displayWidth", QVariant(displayWidth));
    view->rootContext()->setContextProperty("displayHeight", QVariant(displayHeight));

    view->setSource(QStringLiteral("qrc:/main.qml"));
    view->showNormal();

    return app.exec();
}
