#include <algorithm>
#include "traveler.h"
#include "collisionhelper.h"


Traveler::Traveler(QObject *parent) : QObject(parent)
{

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

    int startIndex = currentCoordinateTarget_;
    QList<QGeoCoordinate> geoCoordinates = navigation_->coordinates();

    for (int i=startIndex;i < geoCoordinates.length();i++) {
        // convert into a x/y point
        CollisionHelper::Point targetPoint = CollisionHelper::Point(geoCoordinates[i], position_, mH, mV);

        // if we're without a 15m radius of the point it counts as going in

        if (CollisionHelper::CirclePointCollision(targetPoint, 20, pointPosition)) {
            currentCoordinateTarget_ = std::max(currentCoordinateTarget_, i);
        }
    }

    if (previousTarget != currentCoordinateTarget_) {
        qDebug() << "weeee" << currentCoordinateTarget_;
        emit navigationCoordinateIndexChanged(currentCoordinateTarget_);
    }
}
