#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>
#include <QtQml>
#include "deck.h"
#include "hand.h"
#include "handview.h"
#include <QtDebug>

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


  Deck deck = Deck();

  Hand playerHand = Hand();

  playerHand.AddCard(deck.PopTopCard());
  playerHand.AddCard(deck.PopTopCard());

  HandView *playerHandView = new HandView(nullptr, &playerHand);

  QList<QObject*> playerCardsView = playerHandView->cards();
  qDebug() << playerCardsView.size();

  view->rootContext()->setContextProperty("playerHand", QVariant::fromValue(playerHandView));
  view->rootContext()->setContextProperty("playerHandCards", QVariant::fromValue(playerCardsView));


  view->setSource(QStringLiteral("qrc:/main.qml"));
  view->showNormal();
  //view->showFullScreen();

  return app.exec();
}
