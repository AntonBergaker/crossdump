#include "zone.h"

Zone::Zone(const Zone &other) : QObject(other.parent())
{
    coordinates_ = other.coordinates_;
    name_ = other.name_;
    averagePoint_ = other.averagePoint_;
}

Zone::Zone(QList<QGeoCoordinate> coordinates, QList<QGeoCoordinate> bounds, QString name, QObject *parent) : QObject(parent)
{
    coordinates_ = coordinates;
    bounds_ = bounds;
    name_ = name;

    QGeoCoordinate *average = new QGeoCoordinate(0.0, 0.0);
    for (QGeoCoordinate coord : coordinates) {
        average->setLongitude(average->longitude() + coord.longitude());
        average->setLatitude(average->latitude() + coord.latitude());
    }
    averagePoint_.setLongitude(average->longitude() / coordinates.length());
    averagePoint_.setLatitude(average->latitude() / coordinates.length());
}

QVariantList Zone::coordinatesVariant() {
    QVariantList list = QVariantList();
    for (QGeoCoordinate coord : coordinates_) {
        list.append(QVariant::fromValue(coord));
    }
    return list;
}

QVariantList Zone::boundsVariant() {
    QVariantList list = QVariantList();
    for (QGeoCoordinate bound : bounds_) {
        list.append(QVariant::fromValue(bound));
    }
    return list;
}

Zone::~Zone()
{
}
