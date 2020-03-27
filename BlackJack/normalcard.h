#ifndef NORMALCARD_H
#define NORMALCARD_H

#include "card.h"

class NormalCard : public Card {
 public:
  NormalCard(int value, std::string name, std::string topLetter, std::string colorSource);
  ~NormalCard() {}
  std::string name() {return name_;}
  int value() {return value_;}
  std::string topLetter() {return topLetter_;}
  std::string colorSource() {return colorSource_;}

 private:
  std::string name_;
  std::string topLetter_;
  std::string colorSource_;
  int value_;
};

#endif // NORMALCARD_H
