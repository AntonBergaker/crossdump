#ifndef CARD_H
#define CARD_H

#include <string>

class Card
{
public:
    Card();
    virtual std::string GetName() = 0;
    virtual int GetValue() = 0;
};

#endif // CARD_H
