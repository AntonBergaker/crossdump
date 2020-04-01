#include "route.h"


Route::Route()
{
    points_ = std::vector<Point>();
}

Route::Route(std::vector<Point> points)
{
    points_ = points;
}

std::vector<Point> Route::points()
{
    return points_;
}

/*
 *  Calculates and returns the total distance of the route in meters
 */
double Route::Distance() {
    double total = 0;
    for (int i=1; i < points_.size(); i++)
    {
        total += Point::Distance(points_[i-1], points_[i]);
    }
    return total;
}
