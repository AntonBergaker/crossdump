#include "traveler.h"

Traveler::Traveler(QObject *parent) : QObject(parent)
{

}

void Traveler::setPosition(QGeoCoordinate position)
{
    position_ = position;

    UpdateProgress();

    emit positionChanged(position);
}



void Traveler::UpdateProgress()
{

}
