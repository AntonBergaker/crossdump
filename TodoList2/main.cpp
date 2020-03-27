#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>
#include <QtQml>
#include <QQmlContext>

#include "todolist.h"
#include "todomodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<TodoModel>("Todo", 1, 0, "TodoModel");
    qmlRegisterUncreatableType<TodoList>("Todo", 1, 0, "TodoList",
        QStringLiteral("TodoList should not be registered in QML"));

    TodoList todoList;

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

    view->rootContext()->setContextProperty("targetARM", QVariant(targetARM));
    view->rootContext()->setContextProperty("displayWidth", QVariant(displayWidth));
    view->rootContext()->setContextProperty("displayHeight", QVariant(displayHeight));

    view->rootContext()->setContextProperty("todoList", &todoList);

    view->setSource(QStringLiteral("qrc:/main.qml"));
    view->show();

    return app.exec();
}
