#include "collisionhelper.h"
#include <math.h>

namespace CollisionHelper {

    double PointsDistance(Point p0, Point p1)
    {
        return sqrt(PointsDistanceSquared(p0, p1));
    }

    double PointsDistanceSquared(Point p0, Point p1)
    {
        Point diff = {
            .x = p1.x - p1.x,
            .y = p1.y - p1.y
        };
        return diff.x*diff.x + diff.y*diff.y;
    }

    bool CirclePointCollision(Point circleOrigin, double circleR, Point point)
    {
        Point diff = {
            .x = point.x - circleOrigin.x,
            .y = point.y - circleOrigin.y
        };

        // a^2 + b2 < c^2 is inside circle
        return diff.x*diff.x + diff.y*diff.y <= circleR*circleR;
    }

    bool CircleLineCollision(Point circleOrigin, double circleR, Point point0, Point point1)
    {
        // Taken from http://www.jeffreythompson.org/collision-detection/line-circle.php
        // is either end INSIDE the circle?
        // if so, return true immediately
        if (CirclePointCollision(circleOrigin, circleR, point0)) {
            return true;
        }
        if (CirclePointCollision(circleOrigin, circleR, point1)) {
            return true;
        }

        Point diff = {
            .x = point1.x - point0.x,
            .y = point1.y - point0.y
        };

        double lengthSquared = diff.x*diff.x + diff.y*diff.y;

        // get dot product of the line and circle
        float dot = ( ((circleOrigin.x-point0.x)*diff.x) + ((circleOrigin.y-point0.y)*diff.y) ) / lengthSquared;

        Point closestPoint = {
            .x = point0.x + (dot * diff.x),
            .y = point0.y + (dot * diff.y)
        };

        // is this point actually on the line segment?
        // if so keep going, but if not, return false
        if (LinePointCollision(point0, point1, closestPoint) == false) {
            return false;
        }

        // Check the closest point
        return CirclePointCollision(circleOrigin, circleR, closestPoint);
    }

    bool LinePointCollision(Point lineP0, Point lineP1, Point point) {
        double lineLength = PointsDistance(lineP0, lineP1);
        double length0 = PointsDistance(lineP0, point);
        double length1 = PointsDistance(lineP1, point);

        // If the distance between the ends of the points and the total line length then the point is on the line (with some buffer for floating errors)
        return abs(length0 + length1 - lineLength) < lineLength * 0.001;
    }
}
