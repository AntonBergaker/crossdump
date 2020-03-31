#ifndef ROUTEVIEW_H
#define ROUTEVIEW_H

#include <QObject>
#include "route.h"
#include "pointview.h"

class RouteView : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<PointView*> points READ points CONSTANT)
public:
    explicit RouteView(Route* source_, QObject *parent = nullptr);
    ~RouteView();
    QList<PointView*> points();
signals:

public slots:

private:
    Route* source_;
    QList<PointView*> points_;
};

#endif // ROUTEVIEW_H
