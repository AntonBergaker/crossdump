#include "route.h"

Route::Route(const Route &other) : QObject(other.parent())
{
    zoneList_ = other.zoneList_;
}

Route::Route(QList<Zone*> zones, QString name, QObject *parent) : QObject(parent)
{
    zoneList_ = zones;
    name_ = name;

}

Route::~Route()
{
}

void Route::OptimizeOrder(std::vector<ZoneDistance> zoneDistances)
{
    QList<Zone*> zones;
    QList<Zone*> nextZones = zoneList_;
    QList<Zone*> shortestPath;
    int shortestDistance = 0;
    ShortestRouteDFS(zones, nextZones, &zoneDistances,
                     &shortestPath, &shortestDistance);
    zoneList_ = shortestPath;

    emit zoneListChanged(zoneList());
}

void Route::ShortestRouteDFS(QList<Zone*> zones, QList<Zone*> nextZones,
                             std::vector<ZoneDistance> *zoneDistances,
                             QList<Zone*> *shortestPath,
                             int *shortestDistance)
{
    // We've reached a leaf zone, i.e., the end of a route.
    if (nextZones.empty()) {
        int totalDistance = CalculateDistance(zones, zoneDistances);
        if (totalDistance < *shortestDistance) {
            *shortestPath = zones;
            *shortestDistance = totalDistance;
        }
    } else {
        for (int i = 0; i < nextZones.size(); ++i) {
            Zone *zone = nextZones[i];
            zones.push_back(zone);
            nextZones.removeAt(i);

            ShortestRouteDFS(zones, nextZones, zoneDistances,
                             shortestPath, shortestDistance);

            nextZones.insert(i, zone);
            zones.pop_back();
        }
    }
}

int Route::CalculateDistance(QList<Zone*> zones,
                             std::vector<ZoneDistance> *zoneDistances)
{
    int distance = 0;
    for (int i = 0; i < zones.size() - 1; ++i) {
        distance += GetZoneDistance(zones[i], zones[i + 1], zoneDistances);
    }
    return distance;
}

int Route::GetZoneDistance(Zone *zone1, Zone *zone2,
                           std::vector<ZoneDistance> *zoneDistances)
{
    for (ZoneDistance &distance : *zoneDistances) {
        if ((distance.zone1 == zone1 && distance.zone2 == zone2) ||
            (distance.zone1 == zone2 && distance.zone2 == zone1)) {
            return distance.time;
        }
    }
    return 0;
}
