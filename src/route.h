#ifndef ROUTE_H
#define ROUTE_H

#include <QObject>
#include <QString>

#include "zone.h"

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
    ~Route();

signals:

    public slots:

private:
    QList<Zone*> zoneList_;
    QString name_;
};

#endif // ROUTE_H
