#ifndef COLLISIONHELPER_H
#define COLLISIONHELPER_H

#include <QtPositioning/QGeoCoordinate>
#include <vector>

namespace CollisionHelper {
    class Point {
    public:
        double x;
        double y;

        Point() {}
        Point(double x, double y);
        Point(QGeoCoordinate source, QGeoCoordinate projectedFrom, double xMod, double yMod);
    };

    double PointsDistance(Point p0, Point p1);
    double PointsDistanceSquared(Point p0, Point p1);
    bool CirclePointCollision(Point circleOrigin, double circleR, Point point);
    bool CircleLineCollision(Point circleOrigin, double circleR, Point point0, Point point1);
    bool LinePointCollision(Point lineP0, Point lineP1, Point point);
    bool PointInPolygon(Point point, std::vector<Point> polygon);
}

#endif // COLLISIONHELPER_H
