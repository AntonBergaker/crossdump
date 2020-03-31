#include "routeview.h"
#include <QList>

RouteView::RouteView(Route* source, QObject *parent) : QObject(parent)
{
    source_ = source;
    points_ = QList<PointView*>();

    std::vector<Point> sourcePoints = source_->points();
    for (int i=0;i<sourcePoints.size();i++)
    {
        points_.append(new PointView(&sourcePoints[i]));
    }
}


RouteView::~RouteView() {
    for (PointView* point : points_)
    {
        delete point;
    }
}

QList<PointView*> RouteView::points()
{
    return points_;
}
