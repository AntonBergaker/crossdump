#include "pointview.h"

PointView::PointView(Point* source, QObject *parent) : QObject(parent)
{
    source_ = source;
}
