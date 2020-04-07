#ifndef NAVIGATIONTASK_H
#define NAVIGATIONTASK_H

#include <QObject>
#include <QtLocation/QGeoRoute>
#include <QtLocation/QGeoRouteRequest>
#include <QtLocation/QGeoRoutingManager>

#include "navigation.h"

class NavigationTask : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isDone READ isDone NOTIFY isDoneChanged)
    Q_PROPERTY(Navigation* result READ result NOTIFY resultChanged)
public:
    explicit NavigationTask(QObject *parent = nullptr);
    bool isDone() {return isDone_;}
    Navigation* result() { return result_;}
signals:
    void isDoneChanged(bool);
    void resultChanged(Navigation*);

public slots:
    void RouteCalculated(QGeoRouteReply* reply);

private:
    bool isDone_;
    Navigation* result_;
};

#endif // NAVIGATIONRESULT_H
