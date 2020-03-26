#include "normalcard.h"

NormalCard::NormalCard(int value, std::string name)
{
  value_ = value;
  name_ = name;
}

std::string NormalCard::GetName() {
  return name_;
}

int NormalCard::GetValue() {
  return value_;
}
