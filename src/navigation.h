#ifndef NAVIGATION_H
#define NAVIGATION_H

#include <QObject>
#include <QtLocation/QGeoRoute>

class Navigation : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoRoute source READ source CONSTANT)
    Q_PROPERTY(QList<QGeoRouteSegment*> segments READ segments CONSTANT)
public:
    explicit Navigation(QGeoRoute geoRoute, QObject *parent = nullptr);
    ~Navigation();
    QGeoRoute source() {return source_;}
    QList<QGeoRouteSegment*> segments() {return segments_;}
signals:

public slots:

private:
    QGeoRoute source_;
    QList<QGeoRouteSegment*> segments_;
};

#endif // NAVIGATION_H
