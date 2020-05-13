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
    auto tmp = zoneList_[0];
    zoneList_[0] = zoneList_[zoneList_.size() - 1];
    zoneList_[zoneList_.size() - 1] = tmp;

    emit zoneListChanged(zoneList());
}
