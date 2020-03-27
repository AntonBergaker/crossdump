#include "deck.h"
#include "card.h"
#include "normalcard.h"
#include <QtDebug>
#include <algorithm>

Deck::Deck()
{
  cards = std::vector<Card*>();

  std::string colors[4] = {
    "hearts",
    "diamonds",
    "clubs",
    "spades"
  };

  for (int i=0;i<4;i++) {
    std::string color = colors[i];

    for (int j=2;j<=10;j++) {
      std::string name = std::to_string(j) + " of " + color;
      cards.push_back(new NormalCard(j, name));
    }
    cards.push_back(new NormalCard(10, "Jack of " + color));
    cards.push_back(new NormalCard(10, "Queen of " + color));
    cards.push_back(new NormalCard(10, "King of " + color));
    cards.push_back(new NormalCard(11, "Ace of " + color));
  }

  std::random_shuffle(cards.begin(), cards.end());

  for (int i=0;i<52;i++) {
    qDebug() << cards[i]->GetName().c_str();
  }
}

Deck::~Deck() {
    for (int i=0;i<cards.size();i++) {
        delete cards[i];
    }
}

Card* Deck::PopTopCard() {
    Card* card = cards.back();
    cards.pop_back();
    return card;
}
