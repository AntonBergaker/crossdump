#include "zone.h"

Zone::Zone(QList<QGeoCoordinate> coordinates, QString name, QObject *parent) : QObject(parent)
{
    coordinates_ = coordinates;
    name_ = name;

    QGeoCoordinate *average = new QGeoCoordinate(0.0, 0.0);
    for (QGeoCoordinate coord : coordinates) {
        average->setLongitude(average->longitude() + coord.longitude());
        average->setLatitude(average->latitude() + coord.latitude());
    }
    averagePoint_.setLongitude(average->longitude() / coordinates.length());
    averagePoint_.setLatitude(average->latitude() / coordinates.length());
}
QVariantList Zone::coordinates() {
    QVariantList list = QVariantList();
    for (QGeoCoordinate coord : coordinates_) {
        list.append(QVariant::fromValue(coord));
    }
    return list;
}
Zone::~Zone()
{
}
