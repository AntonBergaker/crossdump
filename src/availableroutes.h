#ifndef AVAILABLEROUTES_H
#define AVAILABLEROUTES_H

#include <QObject>
#include "route.h"

class AvailableRoutes : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Route> routeList READ routeList CONSTANT)
public:
    explicit AvailableRoutes(QObject *parent = nullptr);
    explicit AvailableRoutes(const AvailableRoutes &other) {}
    QQmlListProperty<Route> routeList() {return QQmlListProperty<Route>(this, routeList_);}
    ~AvailableRoutes();

    signals:

    public slots:

private:
    QList<Route*> routeList_;
};

#endif // AVAILABLEROUTES_H
