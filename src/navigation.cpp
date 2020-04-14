#include "navigation.h"
#include <QtLocation/QGeoRouteReply>
#include <QtLocation/QGeoRouteSegment>
#include <QtLocation/QGeoManeuver>
#include <QDebug>

Navigation::Navigation(QGeoRoute geoRoute, QObject *parent) : QObject(parent)
{
    source_ = geoRoute;

    segments_ = QList<NavigationSegment*>();
    coordinates_ = QList<QGeoCoordinate>();

    QGeoRouteSegment seg = geoRoute.firstRouteSegment();

    while (seg.isValid()) {
        segments_.append(new NavigationSegment(&seg) );

        for (QGeoCoordinate coord : seg.path()) {
            coordinates_.append(coord);
        }

        seg = seg.nextRouteSegment();
    }
}

QQmlListProperty<NavigationSegment> Navigation::segments() {
    return QQmlListProperty<NavigationSegment>(this, segments_);
}

QVariantList Navigation::coordinates() {
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
