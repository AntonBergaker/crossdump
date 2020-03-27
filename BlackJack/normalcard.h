#ifndef NORMALCARD_H
#define NORMALCARD_H

#include "card.h"

class NormalCard : public Card {
 public:
  NormalCard(int value, std::string name);
  std::string GetName();
  int GetValue();

 private:
  std::string name_;
  int value_;
};

#endif // NORMALCARD_H
