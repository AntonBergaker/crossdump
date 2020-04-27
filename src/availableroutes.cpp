#include "availableroutes.h"

AvailableRoutes::AvailableRoutes(QObject *parent) : QObject(parent)
{
    routeList_ = QList<Route*>();

    QList<Zone*> zoneList1 = QList<Zone*>();
    QList<Zone*> zoneList2 = QList<Zone*>();
    QList<Zone*> zoneList3 = QList<Zone*>();


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

    QList<QGeoCoordinate> tempQList3 = QList<QGeoCoordinate>();
    tempQList3.append(QGeoCoordinate(59.867470, 17.699388));
    tempQList3.append(QGeoCoordinate(59.866712, 17.700339));
    tempQList3.append(QGeoCoordinate(59.868323, 17.700968));
    tempQList3.append(QGeoCoordinate(59.867885, 17.702753));
    tempQList3.append(QGeoCoordinate(59.867004, 17.702690));
    tempQList3.append(QGeoCoordinate(59.866223, 17.704891));
    tempQList3.append(QGeoCoordinate(59.865035, 17.706990));
    tempQList3.append(QGeoCoordinate(59.865268, 17.708397));
    Zone *arsta = new Zone(tempQList3, QString("Årsta"));

    QList<QGeoCoordinate> tempQList4 = QList<QGeoCoordinate>();
    tempQList4.append(QGeoCoordinate(59.852012, 17.608212));
    tempQList4.append(QGeoCoordinate(59.850702, 17.610547));
    tempQList4.append(QGeoCoordinate(59.849049, 17.607078));
    tempQList4.append(QGeoCoordinate(59.848890, 17.609047));
    Zone *ekeby = new Zone(tempQList4, QString("Ekeby"));

    QList<QGeoCoordinate> tempQList5 = QList<QGeoCoordinate>();
    tempQList5.append(QGeoCoordinate(59.846355, 17.680110));
    Zone *atervinningsstation = new Zone(tempQList5, QString("Återvinningsstation"));

    zoneList1.append(svartbacken);
    zoneList1.append(gamlaUppsala);
    zoneList1.append(arsta);
    zoneList2.append(arsta);
    zoneList2.append(ekeby);
    zoneList2.append(atervinningsstation);
    zoneList3.append(svartbacken);
    zoneList3.append(ekeby);
    routeList_.append(new Route(zoneList1));
    routeList_.append(new Route(zoneList2));
    routeList_.append(new Route(zoneList3));

}

AvailableRoutes::~AvailableRoutes()
{
}
