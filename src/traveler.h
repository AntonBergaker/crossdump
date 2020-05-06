#ifndef TRAVELER_H
#define TRAVELER_H

#include <QObject>
#include "navigation.h"
#include "zone.h"

// Travels through a navigation
class Traveler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Navigation* navigation READ navigation WRITE setNavigation NOTIFY navigationChanged)
    Q_PROPERTY(Zone* targetZone READ targetZone WRITE setTargetZone NOTIFY targetZoneChanged)
    Q_PROPERTY(QGeoCoordinate position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(int navigationCoordinateIndex READ navigationCoordinateIndex NOTIFY navigationCoordinateIndexChanged)
    Q_PROPERTY(int navigationSegmentIndex READ navigationSegmentIndex NOTIFY navigationSegmentIndexChanged)
    Q_PROPERTY(bool insideZone READ insideZone NOTIFY insideZoneChanged)

    Q_PROPERTY(QString nextRoadName READ nextRoadName NOTIFY nextRoadNameChanged)
    Q_PROPERTY(QString nextTurnText READ nextTurnText NOTIFY nextTurnTextChanged)
    Q_PROPERTY(QString nextTurnIcon READ nextTurnIcon NOTIFY nextTurnIconChanged)
    Q_PROPERTY(QString nextTurnDistance READ nextTurnDistance NOTIFY nextTurnDistanceChanged)
public:
    explicit Traveler(QObject *parent = nullptr);
    Navigation* navigation() {return navigation_;}
    void setNavigation(Navigation* navigation);

    Zone* targetZone() {return targetZone_;}
    void setTargetZone(Zone* zone);

    QGeoCoordinate position() {return position_;}
    void setPosition(QGeoCoordinate position);

    int navigationCoordinateIndex() { return currentCoordinateTarget_;}
    int navigationSegmentIndex() { return currentSegment_;}
    bool insideZone() { return insideZone_;}
    QString nextRoadName() {return nextRoadName_;}
    QString nextTurnText() {return nextTurnText_;}
    QString nextTurnIcon() {return nextTurnIcon_;}
    QString nextTurnDistance() {return nextTurnDistance_;}
signals:
    void navigationChanged(Navigation*);
    void targetZoneChanged(Zone*);
    void positionChanged(QGeoCoordinate);
    void navigationCoordinateIndexChanged(int);
    void navigationSegmentIndexChanged(int);
    void insideZoneChanged(bool);
    void nextRoadNameChanged(QString);
    void nextTurnTextChanged(QString);
    void nextTurnIconChanged(QString);
    void nextTurnDistanceChanged(QString);
public slots:

private:
    Navigation* navigation_;
    Zone* targetZone_;
    QGeoCoordinate position_;

    int currentSegment_;
    int currentCoordinateTarget_;
    int currentSegmentCoordinateIndex_;
    bool insideZone_;

    QString nextRoadName_;
    QString nextTurnText_;
    QString nextTurnIcon_;
    QString nextTurnDistance_;

    void ResetProgress(bool emitChanges);
    void UpdateProgress();
    void UpdateInsideZone();
    void UpdateSegmentDetails();
    void UpdateNextTurnDistance();
};

#endif // TRAVELER_H
