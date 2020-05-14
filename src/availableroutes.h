#ifndef AVAILABLEROUTES_H
#define AVAILABLEROUTES_H

#include <QObject>
#include <unordered_map>
#include <utility>
#include "route.h"
#include "navigationtask.h"
#include "navigation.h"

class AvailableRoutes : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Route> routeList READ routeList NOTIFY routeListChanged)
public:
    explicit AvailableRoutes(QObject *parent = nullptr);
    explicit AvailableRoutes(const AvailableRoutes &other) : QObject(other.parent()) {}
    QQmlListProperty<Route> routeList() {return QQmlListProperty<Route>(this, routeList_);}
    ~AvailableRoutes();

    Q_INVOKABLE void updateRoutes(QGeoCoordinate currentLocation);

signals:
    void routeListChanged(QQmlListProperty<Route>);

public slots:
    void ZoneRouteCalculated(Navigation* reply);
    void UserZoneRouteCalculated(Navigation* reply);

private:
    void OptimizeRoutes(QGeoCoordinate currentLocation);
    void OptimizeRoutesWithZoneDistances();

    QList<Route*> routeList_;

    // Used for calculating the shortest route between all zones.
    std::unordered_map<NavigationTask*, Route*> navigationTaskRoutes_;
    std::unordered_map<Route*, std::unordered_map<NavigationTask*, Route::ZoneDistance>> routeZoneDistances_;
    std::unordered_map<NavigationTask*, Zone*> navigationTaskZones_;
    std::unordered_map<Zone*, int> userZoneDistances_;
    int numCalculatedZoneDistances_;
    int totalZoneDistances_;
};

#endif // AVAILABLEROUTES_H
