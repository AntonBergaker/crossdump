#include "navigationtask.h"
#include <QGeoRouteSegment>
#include <QDebug>

NavigationTask::NavigationTask(QObject *parent) : QObject(parent)
{

}

void NavigationTask::setResult(Navigation *result)
{
    isDone_ = false;
    result_ = result;

    emit resultChanged(result);
    emit isDoneChanged(false);
}

void NavigationTask::RouteCalculated(QGeoRouteReply* reply)
{
    if (reply->routes().count() == 0) {
        return;
    }
    QGeoRoute geoRoute = reply->routes().first();
    Navigation* navigation = new Navigation(geoRoute);

    result_ = navigation;
    isDone_ = true;

    emit resultChanged(navigation);
    emit isDoneChanged(true);

}
