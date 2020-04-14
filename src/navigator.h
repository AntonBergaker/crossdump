#ifndef NAVIGATOR_H
#define NAVIGATOR_H

#include <QObject>
#include <QtQml>
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
    Q_INVOKABLE void navigateWithStartEnd(NavigationTask* task, QGeoCoordinate start, QGeoCoordinate end);
    Q_INVOKABLE void navigateWithCoordinates(NavigationTask* task, QVariantList coordinates);
    Q_INVOKABLE void navigateWithRequest(NavigationTask* task, QGeoRouteRequest request);
signals:

public slots:
};

#endif // NAVIGATOR_H
