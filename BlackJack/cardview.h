#ifndef CARDVIEW_H
#define CARDVIEW_H

#include <QObject>
#include "card.h"

class CardView : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name)
    Q_PROPERTY(QString topLetter READ topLetter)
    Q_PROPERTY(QString colorImageSource READ colorImageSource)
public:
    explicit CardView(QObject *parent, Card* card);
    QString name() const {return QString::fromStdString(card_->name());}
    QString topLetter() const;
    QString colorImageSource() const;
signals:

public slots:

private:
    Card* card_;
};

#endif // CARDVIEW_H
