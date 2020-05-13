#ifndef ROUTE_H
#define ROUTE_H

#include <QObject>
#include <vector>
#include <QString>
#include "zone.h"


class Route : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Zone> zoneList READ zoneList NOTIFY zoneListChanged)
    Q_PROPERTY(QString name READ name CONSTANT)
public:
    // Used for optimizing a route.
    struct ZoneDistance {
        ZoneDistance() : zone1(nullptr), zone2(nullptr), time(0) {}

        ZoneDistance(Zone *zone1, Zone *zone2, int time)
            : zone1(zone1), zone2(zone2), time(time) {}

        Zone *zone1;
        Zone *zone2;
        int time;
    };


    explicit Route(const Route &other);
    explicit Route(QObject *parent = nullptr) : QObject(parent) {}
    explicit Route(QList<Zone*> zones, QString name, QObject *parent = nullptr);
    QString name() {return name_;}
    QQmlListProperty<Zone> zoneList() {return QQmlListProperty<Zone>(this, zoneList_);}
    QList<Zone*> &zones() {return zoneList_;}
    ~Route();

    void OptimizeOrder(std::vector<ZoneDistance> task_zones_);
signals:
    void zoneListChanged(QQmlListProperty<Zone>);
public slots:

private:
    QList<Zone*> zoneList_;
    QString name_;
};

#endif // ROUTE_H
