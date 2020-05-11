#include "navigationsegment.h"
#include <QtPositioning/QGeoCoordinate>
#include <QDebug>

NavigationSegment::NavigationSegment(QObject *parent) : QObject(parent)
{
    maneuverRoadName_ = QStringLiteral("");
}

QString ExtractRoadAfterSeperator(QString instructionText, QString seperator)
{
    int index = instructionText.indexOf(seperator);
    if (index == -1) {
        return QStringLiteral("");
    }

    // size of sep and the size of the space
    return instructionText.mid(index+seperator.length()+1);
}

QString ExtractRoad(QString instructionText)
{
    if (instructionText.contains("onto")) {
        return ExtractRoadAfterSeperator(instructionText, "onto");
    }
    if (instructionText.contains("into")) {
        return ExtractRoadAfterSeperator(instructionText, "into");
    }
    if (instructionText.contains("to")) {
        return ExtractRoadAfterSeperator(instructionText, "to");
    }

    return QStringLiteral("");
}

NavigationSegment::NavigationSegment(QGeoRouteSegment* segment, QObject *parent) : QObject(parent)
{
    maneuverRoadName_ = ExtractRoad(segment->maneuver().instructionText());
    maneuverTurnDirection_ = segment->maneuver().direction();

    travelTime_ = segment->travelTime();

    coordinateCount_ = segment->path().count();
    coordinates_ = QList<QGeoCoordinate>(segment->path());
}




NavigationSegment::~NavigationSegment() {

}
