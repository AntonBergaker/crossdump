#include "route.h"

Route::Route(const Route &other) : QObject(other.parent())
{
    zoneList_ = other.zoneList_;
}

Route::Route(QList<Zone*> zones, QObject *parent) : QObject(parent)
{
    zoneList_ = zones;

}
Route::~Route()
{
}

void Route::OptimizeOrder(std::vector<ZoneDistance> zoneDistances)
{

}
