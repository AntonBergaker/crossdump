#ifndef HAND_H
#define HAND_H

#include "hand.h"
#include <vector>
#include "card.h"

class Hand {
 public:
  Hand();
  void AddCard(Card* card);
  int GetSum();
  std::vector<Card*> GetCards();
 private:
  std::vector<Card*> cards;
};

#endif // HAND_H
