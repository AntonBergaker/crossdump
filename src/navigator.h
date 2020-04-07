#ifndef NAVIGATOR_H
#define NAVIGATOR_H

#include <QObject>
#include <QtLocation/QGeoRoute>
#include <QtLocation/QGeoRouteRequest>
#include <QtLocation/QGeoRoutingManager>

#include "navigationtask.h"

// Creates navigations
class Navigator : public QObject
{
    Q_OBJECT
public:
    explicit Navigator(QObject *parent = nullptr);
    Q_INVOKABLE NavigationTask* Navigate(QGeoCoordinate start, QGeoCoordinate end);
signals:

public slots:
};

#endif // NAVIGATOR_H
