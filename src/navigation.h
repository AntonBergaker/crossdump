#ifndef NAVIGATION_H
#define NAVIGATION_H

#include <QObject>
#include <QMetaType>
#include <QVariantList>
#include <QtLocation/QGeoRoute>
#include <QQmlListProperty>
#include "navigationsegment.h"

class Navigation : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoRoute source READ source CONSTANT)
    Q_PROPERTY(int travelTime READ travelTime CONSTANT)
    Q_PROPERTY(QQmlListProperty<NavigationSegment> segments READ segments CONSTANT)
    Q_PROPERTY(QVariantList coordinates READ coordinates CONSTANT)
public:
    explicit Navigation(QGeoRoute geoRoute, QObject *parent = nullptr);
    ~Navigation();
    QGeoRoute source() {return source_;}
    int travelTime() {return source_.travelTime();}
    QQmlListProperty<NavigationSegment> segments();
    QVariantList coordinates();
signals:

public slots:

private:
    QGeoRoute source_;
    QList<NavigationSegment*> segments_;
    QList<QGeoCoordinate> coordinates_;
};


#endif // NAVIGATION_H
