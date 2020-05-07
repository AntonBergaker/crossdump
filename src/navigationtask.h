#ifndef NAVIGATIONTASK_H
#define NAVIGATIONTASK_H

#include <QObject>
#include <QtLocation/QGeoRoute>
#include <QtLocation/QGeoRouteRequest>
#include <QtLocation/QGeoRoutingManager>
//#include "navigator.h"
#include "navigation.h"

class Navigator;

// Holds a navigation that is currently being calculated
class NavigationTask : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isDone READ isDone NOTIFY isDoneChanged)
    Q_PROPERTY(Navigation* result READ result WRITE setResult NOTIFY resultChanged)
public:
    explicit NavigationTask(QObject *parent = nullptr);
    bool isDone() {return isDone_;}
    Navigation* result() { return result_;}
    void setResult(Navigation* result);
    void setResultWithoutResettingAttempts(Navigation* result);
    void setNavigator(Navigator* navigator) {navigator_ = navigator;}
signals:
    void isDoneChanged(bool);
    void resultChanged(Navigation*);

public slots:
    void TryNavigateAgain();
    void RouteCalculated(QGeoRouteReply* reply);

private:
    bool isDone_;
    int navigationAttempts;
    QGeoRouteRequest retryRequest;
    Navigator* navigator_;
    Navigation* result_;
};

#endif // NAVIGATIONRESULT_H
