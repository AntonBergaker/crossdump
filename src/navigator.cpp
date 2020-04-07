#include "navigator.h"

#include "navigationtask.h"
#include <QtLocation/QGeoServiceProviderFactory>
#include <QGeoRouteSegment>
#include <QGeoManeuver>
#include <QDebug>

Navigator::Navigator(QObject *parent) : QObject(parent)
{

}

NavigationTask* Navigator::navigate(QGeoCoordinate start, QGeoCoordinate end)
{
    QList<QGeoCoordinate> coordinates = QList<QGeoCoordinate>();
    coordinates.append(start);
    coordinates.append(end);

    return navigate(coordinates);
}

NavigationTask* Navigator::navigate(QList<QGeoCoordinate> coordinates)
{
    QGeoRouteRequest request = QGeoRouteRequest(coordinates);
    request.setTravelModes(QGeoRouteRequest::TravelMode::CarTravel);

    QVariantMap map = QVariantMap();
    map.insert("bearing", "");

    QList<QVariantMap> metaList = QList<QVariantMap>();
    for (int i=0;i<coordinates.size();i++) {
        metaList.append(map);
        metaList.append(map);
    }
    request.setWaypointsMetadata(metaList);

    qDebug() << "got here";


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
