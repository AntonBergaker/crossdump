#ifndef ROUTE_H
#define ROUTE_H

#include <vector>
#include <QObject>
#include "point.h"

/*
 * Represents the route that's taken between two coordinates
 */
class Route
{
public:
    Route();
    Route(std::vector<Point> points);
    std::vector<Point> points();

private:
    std::vector<Point> points_;
};

#endif // ROUTE_H
