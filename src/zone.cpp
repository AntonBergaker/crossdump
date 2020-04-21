#include "zone.h"

Zone::Zone(Qlist<QGeoCoordinate> coordinates, QString name, QObject *parent) : QObject(parent)
{
    Qlist<QGeoCoordinate> coordinates_ = coordinates;
    QString name_ = name;

    QGeoCoordinate averagePoint_;
    for (int var = 0; var < coordinates.length; ++var) {
        averagePoint_.setLongitude(averagePoint_.longitude() + coordinates[i].longitude);
        averagePoint_.setLatitude(averagePoint_.latitude() + coordinates[i].latitude);
    }
    averagePoint_.setLongitude(averagePoint_.longitude() / coordinates.length);
    averagePoint_.setLatitude(averagePoint_.latitude() / coordinates.length);
}
Zone::~Zone()
{
}
