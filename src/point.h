#ifndef POINT_H
#define POINT_H

/*
 * Represents a single immutable point in the world
 */
class Point
{
public:
    Point(double x, double y);
    double x() const {return x_;}
    double y() const {return y_;}
    static double Distance(Point a, Point b);

private:
    double x_;
    double y_;
};

#endif // POINT_H
