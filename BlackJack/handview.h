#ifndef HANDVIEW_H
#define HANDVIEW_H

#include <QObject>
#include <QList>
#include <string>
#include "hand.h"
#include "cardview.h"
#include <QtQml>

class HandView : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QList<CardView>* cards READ cards)
public:
  HandView(QObject *parent, Hand *hand);
  QList<CardView>* cards() const;
signals:

public slots:

private:
  Hand* hand_;
};

#endif // HANDVIEW_H
