#ifndef POINTVIEW_H
#define POINTVIEW_H

#include <QObject>
#include "point.h"

class PointView : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double x READ x CONSTANT)
    Q_PROPERTY(double y READ y CONSTANT)
public:
    explicit PointView(Point* source, QObject *parent = nullptr);
    double x() { return source_->x;}
    double y() { return source_->y;}
signals:

public slots:

private:
    Point* source_;
};

#endif // POINTVIEW_H
