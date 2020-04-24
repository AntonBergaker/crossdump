#include "availableroutes.h"

AvailableRoutes::AvailableRoutes(QObject *parent) : QObject(parent)
{
    routeList_ = QList<Route*>();

    QList<Zone*> zoneList1 = QList<Zone*>();
    QList<Zone*> zoneList2 = QList<Zone*>();

    QList<QGeoCoordinate> tempQList = QList<QGeoCoordinate>();

    tempQList.append(QGeoCoordinate(59.871749, 17.626814));
    tempQList.append(QGeoCoordinate(59.871135, 17.627174));
    tempQList.append(QGeoCoordinate(59.872576, 17.628881));
    tempQList.append(QGeoCoordinate(59.872057, 17.628982));
    tempQList.append(QGeoCoordinate(59.871605, 17.629222));
    tempQList.append(QGeoCoordinate(59.872576, 17.629599));
    tempQList.append(QGeoCoordinate(59.877239, 17.620151));
    tempQList.append(QGeoCoordinate(59.872037, 17.620264));
    Zone *svartbacken = new Zone(tempQList, QString("Svartbäcken"));


    QList<QGeoCoordinate> tempQList2 = QList<QGeoCoordinate>();

    tempQList2.append(QGeoCoordinate(59.898706, 17.639026));
    tempQList2.append(QGeoCoordinate(59.898089, 17.634557));
    tempQList2.append(QGeoCoordinate(59.897326, 17.633420));
    tempQList2.append(QGeoCoordinate(59.896910, 17.636785));
    tempQList2.append(QGeoCoordinate(59.894180, 17.638513));
    tempQList2.append(QGeoCoordinate(59.892899, 17.638623));
    tempQList2.append(QGeoCoordinate(59.891629, 17.638677));
    Zone *gamlaUppsala = new Zone(tempQList2, QString("Gamla Uppsala"));


    zoneList1.append(svartbacken);
    zoneList1.append(gamlaUppsala);
    zoneList2.append(gamlaUppsala);
    zoneList2.append(svartbacken);
    routeList_.append(new Route(zoneList1));
    routeList_.append(new Route(zoneList2));
}

AvailableRoutes::~AvailableRoutes()
{
}
