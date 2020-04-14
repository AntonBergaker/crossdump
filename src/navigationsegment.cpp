#include "navigationsegment.h"
#include <QtLocation/QGeoManeuver>
#include <QDebug>

NavigationSegment::NavigationSegment(QObject *parent) : QObject(parent)
{
    instructionText_ = QStringLiteral("");
}

NavigationSegment::NavigationSegment(QGeoRouteSegment* segment, QObject *parent) : QObject(parent)
{
    instructionText_ = segment->maneuver().instructionText();
}


NavigationSegment::~NavigationSegment() {

}
