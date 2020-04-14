#include "navigation.h"
#include <QtLocation/QGeoRouteReply>
#include <QtLocation/QGeoRouteSegment>
#include <QtLocation/QGeoManeuver>
#include <QDebug>

Navigation::Navigation(QGeoRoute geoRoute, QObject *parent) : QObject(parent)
{
    source_ = geoRoute;

    segments_ = QList<NavigationSegment*>();

    QGeoRouteSegment seg = geoRoute.firstRouteSegment();

    while (seg.isValid()) {
        segments_.append(new NavigationSegment(&seg) );

        if (seg.isLegLastSegment()) {
            break;
        } else {
            seg = seg.nextRouteSegment();
        }
    }
}

QQmlListProperty<NavigationSegment> Navigation::segments() {
    return QQmlListProperty<NavigationSegment>(this, segments_);
}


Navigation::~Navigation()
{
    for (NavigationSegment* seg : segments_)
    {
        delete seg;
    }
}
