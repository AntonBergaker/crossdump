#ifndef COLLISIONHELPER_H
#define COLLISIONHELPER_H



namespace CollisionHelper {
    struct Point {
        double x;
        double y;
    };

    double PointsDistance(Point p0, Point p1);
    double PointsDistanceSquared(Point p0, Point p1);
    bool CirclePointCollision(Point circleOrigin, double circleR, Point point);
    bool CircleLineCollision(Point circleOrigin, double circleR, Point point0, Point point1);
    bool LinePointCollision(Point lineP0, Point lineP1, Point point);
}

#endif // COLLISIONHELPER_H
