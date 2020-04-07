#include "navigation.h"
#include <QtLocation/QGeoRouteReply>
#include <QtLocation/QGeoRouteSegment>

Navigation::Navigation(QGeoRoute geoRoute, QObject *parent) : QObject(parent)
{
    source_ = geoRoute;

    segments_ = QList<QGeoRouteSegment*>();

    QGeoRouteSegment seg = geoRoute.firstRouteSegment();

    while (seg.isValid()) {
        segments_.append(&seg);

        if (seg.isLegLastSegment()) {
            break;
        } else {
            seg = seg.nextRouteSegment();
        }
    }
}
