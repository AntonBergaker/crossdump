#include "zones.h"

Zones::Zones(QObject *parent) : QObject(parent)
{
    QList<Zone> zoneList_ = QList<Zone>();

    QList<QGeoCoordinate> tempQList = QList<QGeoCoordinate>();
    tempQList.append(QGeoCoordinate(59.871749, 17.626814));
    tempQList.append(QGeoCoordinate(59.871135, 17.627174));
    tempQList.append(QGeoCoordinate(59.872576, 17.628881));
    tempQList.append(QGeoCoordinate(59.872057, 17.628982));
    tempQList.append(QGeoCoordinate(59.871605, 17.629222));
    tempQList.append(QGeoCoordinate(59.872576, 17.629599));
    tempQList.append(QGeoCoordinate(59.877239, 17.620151));
    tempQList.append(QGeoCoordinate(59.872037, 17.620264));
    zoneList_.append(Zone(tempQList, "Svartbäcken"));
}
Zones::~Zones()
{
}
