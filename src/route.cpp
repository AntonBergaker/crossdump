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
