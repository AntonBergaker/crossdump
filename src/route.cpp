#include "route.h"

Route::Route(QList<Zone*> zones, QObject *parent) : QObject(parent)
{
    zoneList_ = zones;

}
Route::~Route()
{
}
