#include "point.h"
#include <bits/stdc++.h>

Point::Point(double x, double y)
{
    this->x_ = x;
    this->y_ = y;
}


// Utility function for
// converting degrees to radians
long double toRadians(const long double degree)
{
    // cmath library in C++
    // defines the constant
    // M_PI as the value of
    // pi accurate to 1e-30
    long double one_deg = (M_PI) / 180;
    return (one_deg * degree);
}


/*
 * Calculate and return the distance in meters between two points
 */
double Point::Distance(Point a, Point b)
{
    // Source: https://www.geeksforgeeks.org/program-distance-two-points-earth/

    // Convert the latitudes
    // and longitudes
    // from degree to radians.
    double lat1 = toRadians(a.x());
    double long1 = toRadians(a.y());
    double lat2 = toRadians(b.x());
    double long2 = toRadians(b.y());

    // Haversine Formula
    long double dlong = long2 - long1;
    long double dlat = lat2 - lat1;

    long double ans = pow(sin(dlat / 2), 2) +
                          cos(lat1) * cos(lat2) *
                          pow(sin(dlong / 2), 2);

    ans = 2 * asin(sqrt(ans));

    // Radius of Earth in
    // Kilometers, R = 6371
    // Use R = 3956 for miles
    long double R = 6371000;

    // Calculate the result
    ans = ans * R;

    return ans;
}
