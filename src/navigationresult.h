#ifndef NAVIGATIONRESULT_H
#define NAVIGATIONRESULT_H

#include <QObject>
#include <QtLocation/QGeoRoute>
#include <QtLocation/QGeoRouteRequest>
#include <QtLocation/QGeoRoutingManager>

#include "navigation.h"

class NavigationResult : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isDone READ isDone NOTIFY isDoneChanged)
    Q_PROPERTY(Navigation* result READ result NOTIFY resultChanged)
public:
    explicit NavigationResult(QObject *parent = nullptr);
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
