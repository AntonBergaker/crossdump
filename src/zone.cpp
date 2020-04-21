#include "zone.h"

Zone::Zone(QList<QGeoCoordinate> coordinates, QString name, QObject *parent) : QObject(parent)
{
    QList<QGeoCoordinate> coordinates_ = coordinates;
    QString name_ = name;

    QGeoCoordinate averagePoint_;
    for (int i = 0; i < coordinates.length(); ++i) {
        averagePoint_.setLongitude(averagePoint_.longitude() + coordinates[i].longitude());
        averagePoint_.setLatitude(averagePoint_.latitude() + coordinates[i].latitude());
    }
    averagePoint_.setLongitude(averagePoint_.longitude() / coordinates.length());
    averagePoint_.setLatitude(averagePoint_.latitude() / coordinates.length());
}
Zone::~Zone()
{
}
