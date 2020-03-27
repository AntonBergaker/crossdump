#include "hand.h"
#include <vector>

Hand::Hand() {
  cards = std::vector<Card*>();
}

void Hand::AddCard(Card * card) {
  cards.push_back(card);
}

int Hand::GetSum() {
  int sum = 0;
  for (Card* card : cards) {
    sum += card->GetValue();
  }
  return sum;
}

std::vector<Card*> Hand::GetCards() {
  return cards;
}
