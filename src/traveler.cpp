#include <algorithm>
#include "traveler.h"
#include "collisionhelper.h"


Traveler::Traveler(QObject *parent) : QObject(parent)
{
    nextRoadName_ = QStringLiteral("");
    nextTurnText_ = QStringLiteral("");
}

void Traveler::setPosition(QGeoCoordinate position)
{
    position_ = position;

    if (navigation_ != nullptr) {
        UpdateProgress();
    }

    emit positionChanged(position);
}

void Traveler::UpdateProgress()
{
    int previousTarget = currentCoordinateTarget_;
    // Project the coordinates into a 2d space where each unit is one meter

    // TODO: make sure this works closer to the poles
    QGeoCoordinate oneUnitHorizontal = QGeoCoordinate(position_.latitude()+1, position_.longitude());
    QGeoCoordinate oneUnitVertical   = QGeoCoordinate(position_.latitude()  , position_.longitude()+1);

    // Get how much one unit is worth in meters, which we use as modifiers going forward.
    double /*metersHorizontal*/ mH = position_.distanceTo(oneUnitHorizontal);
    double /*metersVertical  */ mV = position_.distanceTo(oneUnitVertical);

    CollisionHelper::Point pointPosition = CollisionHelper::Point(position_, position_, mH, mV);

    QList<QGeoCoordinate> geoCoordinates = navigation_->coordinates();

    //Check for collisions with points
    for (int i=currentCoordinateTarget_;i < geoCoordinates.length();i++) {
        // convert into a x/y point
        CollisionHelper::Point targetPoint = CollisionHelper::Point(geoCoordinates[i], position_, mH, mV);

        // if we're without a 20m radius of the point it counts as going in

        if (CollisionHelper::CirclePointCollision(targetPoint, 20, pointPosition)) {
            currentCoordinateTarget_ = std::max(currentCoordinateTarget_, i);
        }
    }

    // Check for collisions with lines
    for (int i=currentCoordinateTarget_; i < geoCoordinates.length()-1;i++) {

        CollisionHelper::Point startPoint = CollisionHelper::Point(geoCoordinates[i], position_, mH, mV);
        CollisionHelper::Point endPoint = CollisionHelper::Point(geoCoordinates[i+1], position_, mH, mV);

        if (CollisionHelper::CircleLineCollision(pointPosition, 20, startPoint, endPoint)) {
            currentCoordinateTarget_ = std::max(currentCoordinateTarget_, i);
        }
    }

    if (previousTarget != currentCoordinateTarget_) {
        emit navigationCoordinateIndexChanged(currentCoordinateTarget_);

        int oldSegment = currentSegment_;
        // find the current segment we're at
        int toRemove = currentCoordinateTarget_;
        for (int i=0;i<navigation_->segments().count();i++) {
            toRemove -= navigation_->segments().at(i)->coordinateCount();
            if (toRemove <= 0) {
                currentSegment_ = i;
                break;
            }
        }
        if (oldSegment != currentSegment_) {
            UpdateSegmentDetails();
            emit navigationSegmentIndexChanged(currentSegment_);
        }

    }
}

QString GetManueverText(QGeoManeuver::InstructionDirection direction)
{
    switch (direction) {
        case QGeoManeuver::DirectionHardRight:
        case QGeoManeuver::DirectionBearRight:
        case QGeoManeuver::DirectionRight:
            return QStringLiteral("Turn right");

        case QGeoManeuver::DirectionLightRight:
            return QStringLiteral("Turn slightly right");

        case QGeoManeuver::DirectionHardLeft:
        case QGeoManeuver::DirectionBearLeft:
        case QGeoManeuver::DirectionLeft:
            return QStringLiteral("Turn left");

        case QGeoManeuver::DirectionLightLeft:
            return QStringLiteral("Turn slightly left");

        case QGeoManeuver::DirectionForward:
            return QStringLiteral("Go forward");

        case QGeoManeuver::DirectionUTurnLeft:
        case QGeoManeuver::DirectionUTurnRight:
            return QStringLiteral("Make a u-turn");

        case QGeoManeuver::NoDirection:
            return QStringLiteral("");
    }
    return QStringLiteral("");
}

void Traveler::UpdateSegmentDetails()
{
    if (navigation()->segments().count() <= currentSegment_+1) {
        nextRoadName_ = QStringLiteral("Destination");
        nextTurnText_ = QStringLiteral("");
    } else {

        NavigationSegment* next = navigation()->segments().at(currentSegment_+1);

        nextRoadName_ = next->maneuverRoadName();
        nextTurnText_ = GetManueverText(next->maneuverTurnDirection());
    }

    emit nextRoadNameChanged(nextRoadName_);
    emit nextTurnTextChanged(nextTurnText_);

}
