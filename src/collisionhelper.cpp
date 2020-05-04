#include "collisionhelper.h"
#include <math.h>

namespace CollisionHelper {

    Point::Point(double x, double y) {
        this->x = x;
        this->y = y;
    }

    Point::Point(QGeoCoordinate source, QGeoCoordinate projectedFrom, double xModifier, double yModifier) {
        this->x = (source.latitude()  - projectedFrom.latitude() ) * xModifier;
        this->y = (source.longitude() - projectedFrom.longitude()) * yModifier;
    }

    double PointsDistance(Point p0, Point p1)
    {
        return sqrt(PointsDistanceSquared(p0, p1));
    }

    double PointsDistanceSquared(Point p0, Point p1)
    {
        Point diff = Point(p0.x - p1.x, p0.y - p1.y);
        return diff.x*diff.x + diff.y*diff.y;
    }

    bool CirclePointCollision(Point circleOrigin, double circleR, Point point)
    {
        Point diff = Point(point.x - circleOrigin.x, point.y - circleOrigin.y);

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

        Point diff = Point(point1.x - point0.x, point1.y - point0.y);

        double lengthSquared = diff.x*diff.x + diff.y*diff.y;

        // get dot product of the line and circle
        float dot = ( ((circleOrigin.x-point0.x)*diff.x) + ((circleOrigin.y-point0.y)*diff.y) ) / lengthSquared;

        Point closestPoint = Point(point0.x + (dot * diff.x), point0.y + (dot * diff.y));

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
        return abs(length0 + length1 - lineLength) <= lineLength * 0.001;
    }

    bool PointInPolygon(Point point, std::vector<Point> polygon)
    {
        // Taken from http://alienryderflex.com/polygon/
        bool oddNodes = false;

        double x = point.x;
        double y = point.y;

        int j = polygon.size()-1 ;

        for (int i=0; i< polygon.size(); i++) {
            if ((polygon[i].y < y && polygon[j].y >= y
            ||   polygon[j].y < y && polygon[i].y >= y)
            &&  (polygon[i].x <=x || polygon[j].x <= x)) {
                if (polygon[i].x +(y-polygon[i].y)/(polygon[j].y-polygon[i]-y)*(polygon[j].x-polygon[i].x)<x) {
                    oddNodes=!oddNodes;
                }
            }
            j=i;
        }

        return oddNodes;
    }

}
