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

    Navigation* navigation = new Navigation(geoRoute);

    result_ = navigation;
    isDone_ = true;

    emit resultChanged(navigation);
    emit isDoneChanged(true);

}
