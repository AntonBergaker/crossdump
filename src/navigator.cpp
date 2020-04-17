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

    navigateWithRequest(task, request);
}

void Navigator::navigateWithRequest(NavigationTask* task, QGeoRouteRequest request)
{

    QGeoServiceProvider* prov = new QGeoServiceProvider("osm");
    QGeoRoutingManager* routeManager = prov->routingManager();
    routeManager->calculateRoute(request);
    task->setResult(nullptr);
    task->connect(routeManager,
            SIGNAL(finished(QGeoRouteReply*)),
            task,
            SLOT(RouteCalculated(QGeoRouteReply*)));
}
