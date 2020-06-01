#include "navigator.h"

#include "navigationtask.h"
#include <QtLocation/QGeoServiceProviderFactory>
#include <QGeoRouteSegment>
#include <QGeoManeuver>
#include <QDebug>

Navigator::Navigator(QObject *parent) : QObject(parent)
{

}

void Navigator::navigateWithStartEnd(NavigationTask* task, QGeoCoordinate start, QGeoCoordinate end)
{
    QVariantList coordinates = QVariantList();
    coordinates.append(QVariant::fromValue(start));
    coordinates.append(QVariant::fromValue(end));

    navigateWithCoordinates(task, coordinates);
}

void Navigator::navigateWithCoordinates(NavigationTask* task, QVariantList coordinates)
{
    QList<QGeoCoordinate> coordinatesList = QList<QGeoCoordinate>();
    for (QVariant q : coordinates)
    {
        coordinatesList.append(q.value<QGeoCoordinate>());
    }

    QGeoRouteRequest request = QGeoRouteRequest(coordinatesList.first(), coordinatesList.last());
    request.setTravelModes(QGeoRouteRequest::TravelMode::CarTravel);

    QVariantMap map = QVariantMap();
    map.insert("bearing", "");

    request.setWaypoints(coordinatesList);

    QList<QVariantMap> metaList = QList<QVariantMap>();
    for (int i=0;i<coordinatesList.size();i++) {
        metaList.append(map);
        metaList.append(map);
    }
    request.setWaypointsMetadata(metaList);

    navigateWithRequest(task, request, true);
}

void Navigator::navigateWithRequest(NavigationTask* task, QGeoRouteRequest request, bool isNewRequest)
{
    QVariantMap map = QVariantMap();
    map.insert("mapbox.access_token", "pk.eyJ1IjoiY2Fsdml0b24iLCJhIjoiY2s4anVjejFlMGRvMDNsbjYxa2w0YWhlYiJ9.Ke_LEN3--vioiy_T8dqDjw");
    QGeoServiceProvider* prov = new QGeoServiceProvider("mapbox", map);
    QGeoRoutingManager* routeManager = prov->routingManager();
    routeManager->calculateRoute(request);
    task->setNavigator(this);
    if (isNewRequest) {
        task->setResult(nullptr);
    } else {
        task->setResultWithoutResettingAttempts(nullptr);
    }
    task->connect(routeManager,
            SIGNAL(finished(QGeoRouteReply*)),
            task,
            SLOT(RouteCalculated(QGeoRouteReply*)));
}
