#include "navigationtask.h"
#include <QGeoRouteSegment>
#include <QDebug>

NavigationTask::NavigationTask(QObject *parent) : QObject(parent)
{

}

void NavigationTask::RouteCalculated(QGeoRouteReply* reply)
{
    QGeoRoute geoRoute = reply->routes().first();

    Navigation* navigation = new Navigation(geoRoute);

    result_ = navigation;
    isDone_ = true;

    emit resultChanged(navigation);
    emit isDoneChanged(true);

}
