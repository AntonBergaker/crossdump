#include "navigationtask.h"
#include <QGeoRouteSegment>
#include <QDebug>

#include "navigator.h"

NavigationTask::NavigationTask(QObject *parent) : QObject(parent)
{
    navigationAttempts = 0;
    isDone_ = false;
    navigator_ = nullptr;
}

void NavigationTask::setResult(Navigation *result)
{
    navigationAttempts = 0;
    setResultWithoutResettingAttempts(result);
}

void NavigationTask::setResultWithoutResettingAttempts(Navigation *result)
{
    isDone_ = false;
    result_ = result;

    emit resultChanged(result);
    emit isDoneChanged(false);
}

void NavigationTask::TryNavigateAgain()
{
    navigator_->navigateWithRequest(this, retryRequest, false);
}

void NavigationTask::RouteCalculated(QGeoRouteReply* reply)
{
    if (reply->routes().count() == 0) {
        // try again 10 times
        if (navigationAttempts >= 10) {
            return;
        }

        navigationAttempts++;
        qDebug() << "Navigation failed, trying again in " << navigationAttempts << " second(s) " << navigationAttempts << "/10";

        retryRequest = reply->request();
        QTimer::singleShot(1000 * navigationAttempts, this, SLOT(TryNavigateAgain()));
        return;
    }
    QGeoRoute geoRoute = reply->routes().first();
    Navigation* navigation = new Navigation(geoRoute);

    result_ = navigation;
    isDone_ = true;

    emit resultChanged(navigation);
    emit isDoneChanged(true);

}
