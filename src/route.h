#ifndef ROUTE_H
#define ROUTE_H

#include <QObject>
<<<<<<< HEAD
#include <vector>
=======
#include <QString>

>>>>>>> e56c17342991c5ee7f618bb8a5d152776ae4e7e9
#include "zone.h"

// Used for optimizing a route.
struct ZoneDistance {
  ZoneDistance(Zone *zone1, Zone *zone2, int time)
      : zone1(zone1), zone2(zone2), time(time) {}

  Route *route;
  Zone *zone1;
  Zone *zone2;
  int time;
};

class Route : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Zone> zoneList READ zoneList CONSTANT)
    Q_PROPERTY(QString name READ name CONSTANT)
public:
    explicit Route(const Route &other);
    explicit Route(QObject *parent = nullptr) : QObject(parent) {}
    explicit Route(QList<Zone*> zones, QString name, QObject *parent = nullptr);
    QString name() {return name_;}
    QQmlListProperty<Zone> zoneList() {return QQmlListProperty<Zone>(this, zoneList_);}
    QList<Zone*> &zones() {return zoneList_;}
    ~Route();

<<<<<<< HEAD
    void OptimizeOrder(std::vector<ZoneDistance> task_zones_);

    signals:
=======
signals:
>>>>>>> e56c17342991c5ee7f618bb8a5d152776ae4e7e9

    public slots:

private:
    QList<Zone*> zoneList_;
    QString name_;
};

#endif // ROUTE_H
