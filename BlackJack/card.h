#ifndef CARD_H
#define CARD_H

#include <string>

class Card
{
public:
    Card();
    virtual ~Card() {}
    virtual std::string name() = 0;
    virtual int value() = 0;
};

#endif // CARD_H
