#ifndef CARDVIEW_H
#define CARDVIEW_H

#include <QObject>

class CardView : public QObject
{
  Q_OBJECT
public:
  explicit CardView(QObject *parent = nullptr);

signals:

public slots:
};

#endif // CARDVIEW_H
