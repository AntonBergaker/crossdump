#include "deck.h"
#include "card.h"
#include "normalcard.h"
#include <QtDebug>
#include <algorithm>
#include <stdlib.h>

Deck::Deck()
{
    cards = std::vector<Card*>();

    std::string colors[4] = {
        "hearts",
        "diamonds",
        "clubs",
        "spades"
    };

    std::string colorSources[4] = {
        "Hearts.png",
        "Diamonds.png",
        "Clubs.png",
        "Spades.png"
    };

    for (int i=0;i<4;i++) {
        std::string color = colors[i];
        std::string colorSource = colorSources[i];

        for (int j=2;j<=10;j++) {
          std::string name = std::to_string(j) + " of " + color;
          cards.push_back(new NormalCard(j, name, std::to_string(j), colorSource));
        }
        cards.push_back(new NormalCard(10, "Jack of " + color, "J", colorSource));
        cards.push_back(new NormalCard(10, "Queen of " + color, "Q", colorSource));
        cards.push_back(new NormalCard(10, "King of " + color, "K", colorSource));
        cards.push_back(new NormalCard(11, "Ace of " + color, "A", colorSource));
        }

        std::srand(time(0));
        std::random_shuffle(cards.begin(), cards.end());
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
