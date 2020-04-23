#ifndef ZONES_H
#define ZONES_H

#include <QObject>

#include "zone.h"

class Zones : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Zone> zoneList READ zoneList CONSTANT)
public:
    explicit Zones(const Zones &other) {}
    explicit Zones(QObject *parent = nullptr);
    QQmlListProperty<Zone> zoneList() {return QQmlListProperty<Zone>(this, zoneList_);}
    ~Zones();

    signals:

    public slots:

private:
    QList<Zone*> zoneList_;
};

#endif // ZONES_H
