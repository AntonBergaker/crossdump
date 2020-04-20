#ifndef TRAVELER_H
#define TRAVELER_H

#include <QObject>
#include "navigation.h"

// Travels through a navigation
class Traveler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Navigation* navigation READ navigation WRITE setNavigation NOTIFY navigationChanged)
    Q_PROPERTY(QGeoCoordinate position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(int navigationCoordinateIndex READ navigationCoordinateIndex NOTIFY navigationCoordinateIndexChanged)
public:
    explicit Traveler(QObject *parent = nullptr);
    Navigation* navigation() {return navigation_;}
    void setNavigation(Navigation* navigation) {navigation_ = navigation; emit navigationChanged(navigation);}

    QGeoCoordinate position() {return position_;}
    void setPosition(QGeoCoordinate position);

    int navigationCoordinateIndex() { return currentCoordinateTarget_;}
signals:
    void navigationChanged(Navigation*);
    void positionChanged(QGeoCoordinate);
    void navigationCoordinateIndexChanged(int);
public slots:

private:
    Navigation* navigation_;
    QGeoCoordinate position_;

    int currentCoordinateTarget_;

    void UpdateProgress();
};

#endif // TRAVELER_H
