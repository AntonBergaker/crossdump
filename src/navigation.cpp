#include "navigation.h"
#include <QtLocation/QGeoRouteReply>
#include <QtLocation/QGeoRouteSegment>
#include <QtLocation/QGeoManeuver>
#include <QDebug>

Navigation::Navigation(QGeoRoute geoRoute, QObject *parent) : QObject(parent)
{

    segments_ = QList<NavigationSegment*>();
    coordinates_ = QList<QGeoCoordinate>();
    travelTime_ = geoRoute.travelTime();

    QGeoRouteSegment seg = geoRoute.firstRouteSegment();

    while (seg.isValid()) {
        segments_.append(new NavigationSegment(&seg) );

        for (QGeoCoordinate coord : seg.path()) {
            coordinates_.append(coord);
        }

        seg = seg.nextRouteSegment();
    }
}

QQmlListProperty<NavigationSegment> Navigation::segmentsListProperty() {
    return QQmlListProperty<NavigationSegment>(this, segments_);
}

QVariantList Navigation::coordinatesVariant() {
    QVariantList list = QVariantList();
    for (QGeoCoordinate coord : coordinates_) {
        list.append(QVariant::fromValue(coord));
    }
    return list;
}

Navigation::~Navigation()
{
    for (NavigationSegment* seg : segments_)
    {
        delete seg;
    }
}
