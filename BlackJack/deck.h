#ifndef DECK_H
#define DECK_H

#include <vector>
#include "card.h"

class Deck {
 public:
  Deck();
  ~Deck();
  Card* PopTopCard();
private:
  std::vector<Card*> cards;
};

#endif // DECK_H
