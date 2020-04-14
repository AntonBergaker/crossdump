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
    Q_PROPERTY(QQmlListProperty<NavigationSegment> segments READ segments CONSTANT)
public:
    explicit Navigation(QGeoRoute geoRoute, QObject *parent = nullptr);
    ~Navigation();
    QGeoRoute source() {return source_;}
    QQmlListProperty<NavigationSegment> segments();
signals:

public slots:

private:
    QGeoRoute source_;
    QList<NavigationSegment*> segments_;
};


#endif // NAVIGATION_H
