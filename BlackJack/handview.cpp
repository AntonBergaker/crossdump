#include "handview.h"


HandView::HandView(QObject *parent, Hand* hand) : QObject(parent)
{
    hand_ = hand;
}


QList<QObject*> HandView::cards() const {
  std::vector<Card*> handCards = hand_->GetCards();
  QList<QObject*> cardViews = QList<QObject*>();
  for (int i=0; i < handCards.size(); i++) {
    cardViews.append(new CardView(nullptr, handCards[i]));
  }
  return cardViews;
}
