#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>
#include <QtQml>
#include "deck.h"
#include "hand.h"
#include "handview.h"

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

  view->rootContext()->setContextProperty("targetARM", QVariant(targetARM));
  view->rootContext()->setContextProperty("displayWidth", QVariant(displayWidth));
  view->rootContext()->setContextProperty("displayHeight", QVariant(displayHeight));

  view->setSource(QStringLiteral("qrc:/main.qml"));
  view->showNormal();
  //view->showFullScreen();

  Deck deck = Deck();

  Hand playerHand = Hand();

  playerHand.AddCard(deck.PopTopCard());
  playerHand.AddCard(deck.PopTopCard());

  qmlRegisterType<HandView>("com.calviton.handview", 1, 0, "HandView");

  HandView* playerHandView = new HandView(nullptr, &playerHand);


  return app.exec();
}
