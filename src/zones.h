#ifndef ZONES_H
#define ZONES_H

#include <QObject>

#include "zone.h"

class Zones : public QObject
{
    Q_OBJECT
public:
    explicit Zones(const Zones &other) {}
    explicit Zones(QObject *parent = nullptr);
    QList<Zone> zoneList() {return zoneList_;}
    ~Zones();

    signals:

    public slots:

private:
    QList<Zone> zoneList_;
};

#endif // ZONES_H
