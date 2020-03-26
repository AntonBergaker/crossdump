#include "handview.h"


HandView::HandView(QObject *parent, Hand* hand) : QObject(parent)
{
  hand_ = hand;
}

QList<CardView>* HandView::cards() const {
  return nullptr;
}
