#include "cardview.h"
#include "normalcard.h"

#include <QDebug>

CardView::CardView(QObject *parent, Card* card) : QObject(parent)
{
    card_ = card;
}

QString CardView::topLetter() const {
    if (true) {
       NormalCard* normalCard = dynamic_cast<NormalCard*>(card_);
       return QString::fromStdString(normalCard->topLetter());
    }
    return QStringLiteral("");
}

QString CardView::colorImageSource() const {
    if (true) {
       NormalCard* normalCard = dynamic_cast<NormalCard*>(card_);
       return QString::fromStdString(normalCard->colorSource());
    }
    return QStringLiteral("");
}
