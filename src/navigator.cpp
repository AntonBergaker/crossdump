#include "navigator.h"

#include "navigationtask.h"
#include <QtLocation/QGeoServiceProviderFactory>
#include <QGeoRouteSegment>
#include <QGeoManeuver>
#include <QDebug>

Navigator::Navigator(QObject *parent) : QObject(parent)
{

}

NavigationTask* Navigator::Navigate(QGeoCoordinate start, QGeoCoordinate end)
{
    QList<QGeoCoordinate> list = QList<QGeoCoordinate>();
    list.append(start);
    list.append(end);
    QGeoRouteRequest request = QGeoRouteRequest(list);
    request.setTravelModes(QGeoRouteRequest::TravelMode::CarTravel);

    QVariantMap map = QVariantMap();
    map.insert("bearing", "");

    QList<QVariantMap> metaList = QList<QVariantMap>();
    metaList.append(map);
    metaList.append(map);
    request.setWaypoints(list);
    request.setWaypointsMetadata(metaList);


    QGeoServiceProvider* prov = new QGeoServiceProvider("osm");
    QGeoRoutingManager* routeManager = prov->routingManager();
    routeManager->calculateRoute(request);

    NavigationTask* result = new NavigationTask();

    result->connect(routeManager,
            SIGNAL(finished(QGeoRouteReply*)),
            result,
            SLOT(RouteCalculated(QGeoRouteReply*)));

    return result;
}
