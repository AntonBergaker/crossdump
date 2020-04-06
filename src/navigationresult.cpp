#include "navigationresult.h"
#include <QGeoRouteSegment>
#include <QGeoManeuver>
#include <QDebug>

NavigationResult::NavigationResult(QObject *parent) : QObject(parent)
{

}

void NavigationResult::RouteCalculated(QGeoRouteReply* reply)
{
    QGeoRoute geoRoute = reply->routes().first();

    QGeoRouteSegment seg = geoRoute.firstRouteSegment();
    while (seg.isValid()) {

        QGeoManeuver man = seg.maneuver();
        qDebug() << man.instructionText();

        if (seg.isLegLastSegment()) {
            break;
        } else {
            seg = seg.nextRouteSegment();
        }
    }

    Navigation* navigation = new Navigation();

    result_ = navigation;
    isDone_ = true;

    emit resultChanged(navigation);
    emit isDoneChanged(true);

}
