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
    Q_PROPERTY(QQmlListProperty<Route> routeList READ routeList CONSTANT)
public:
    explicit AvailableRoutes(QObject *parent = nullptr);
    explicit AvailableRoutes(const AvailableRoutes &other) : QObject(other.parent()) {}
    QQmlListProperty<Route> routeList() {return QQmlListProperty<Route>(this, routeList_);}
    ~AvailableRoutes();

signals:

public slots:
    void RouteCalculated(Navigation* reply);

private:
    QList<Route*> routeList_;

    // Used for calculating the shortest route between all zones.
    std::unordered_map<NavigationTask*, Route*> navigationTaskRoutes_;
    std::unordered_map<Route*, std::unordered_map<NavigationTask*, Route::ZoneDistance>> routeZoneDistances_;
    int numCalculatedZoneDistances_;
    int totalZoneDistances_;
};

#endif // AVAILABLEROUTES_H
