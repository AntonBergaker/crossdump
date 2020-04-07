#include "navigation.h"
#include <QtLocation/QGeoRouteReply>
#include <QtLocation/QGeoRouteSegment>
#include <QDebug>

Navigation::Navigation(QGeoRoute geoRoute, QObject *parent) : QObject(parent)
{
    source_ = geoRoute;

    segments_ = QList<QGeoRouteSegment*>();

    QGeoRouteSegment seg = geoRoute.firstRouteSegment();

    qDebug() << "got here";

    while (seg.isValid()) {
        segments_.append(new QGeoRouteSegment(seg));

        if (seg.isLegLastSegment()) {
            break;
        } else {
            seg = seg.nextRouteSegment();
        }
    }
}

Navigation::~Navigation()
{
    for (QGeoRouteSegment* seg : segments_)
    {
        delete seg;
    }
}
