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
  Q_PROPERTY(QList<QObject*> cards READ cards CONSTANT)
  Q_PROPERTY(QString name READ name CONSTANT)
public:
    HandView(QObject *parent, Hand* hand);
    QList<QObject*> cards() const;
    QString name() const {return ":(";}
signals:

public slots:

private:
  Hand* hand_;
};

#endif // HANDVIEW_H
