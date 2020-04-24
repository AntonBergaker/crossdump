#include "availableroutes.h"

AvailableRoutes::AvailableRoutes(QObject *parent) : QObject(parent)
{
    routeList_ = QList<Route*>();
    routeList_.append(new Route());
    routeList_.append(new Route());

}

AvailableRoutes::~AvailableRoutes()
{
}
