#ifndef ROUTE_H
#define ROUTE_H

#include <QObject>

#include "zone.h"

class Route : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Zone> zoneList READ zoneList CONSTANT)
public:
    explicit Route(const Route &other)  : QObject() {}
    explicit Route(QObject *parent = nullptr) : QObject(parent) {}
    explicit Route(QList<Zone*> zones, QObject *parent = nullptr);
    QQmlListProperty<Zone> zoneList() {return QQmlListProperty<Zone>(this, zoneList_);}
    ~Route();

    signals:

    public slots:

private:
    QList<Zone*> zoneList_;
};

#endif // ROUTE_H
