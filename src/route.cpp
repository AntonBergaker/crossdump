#include "route.h"


Route::Route()
{
    points_ = std::vector<Point>();
}

Route::Route(std::vector<Point> points) {
    points_ = points;
}

std::vector<Point> Route::points()
{
    return points_;
}
