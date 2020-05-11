#ifndef NAVIGATIONSEGMENT_H
#define NAVIGATIONSEGMENT_H

#include <QObject>
#include <QtLocation/QGeoRouteSegment>
#include <QtLocation/QGeoManeuver>
#include <QtPositioning/QGeoCoordinate>
#include <QDebug>

// A small segment of a navigation, usually the size of a road before you need to take action with
// your vechicle, like turning onto another road
class NavigationSegment  : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString maneuverRoadName READ maneuverRoadName CONSTANT)
public:
    explicit NavigationSegment(QObject *parent = nullptr);
    explicit NavigationSegment(QGeoRouteSegment* segment, QObject *parent = nullptr);
    ~NavigationSegment();
    int coordinateCount() {return coordinateCount_;}
    QString maneuverRoadName() {return maneuverRoadName_;}
    QList<QGeoCoordinate> coordinates() {return coordinates_;}
    QGeoManeuver::InstructionDirection maneuverTurnDirection() {return maneuverTurnDirection_;}
    int travelTime() {return travelTime_;}

private:
    int coordinateCount_;
    QGeoManeuver::InstructionDirection maneuverTurnDirection_;
    QString maneuverRoadName_;
    QList<QGeoCoordinate> coordinates_;
    int travelTime_;
};


#endif // NAVIGATIONSEGMENT_H
