#ifndef NAVIGATION_H
#define NAVIGATION_H

#include <QObject>
#include <QtLocation/QGeoRouteReply>

class Navigation : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoRouteReply* source READ source CONSTANT)
    Q_PROPERTY(QList<QGeoRouteSegment>* segments READ segments CONSTANT)
public:
    explicit Navigation(QGeoRoute geoRoute, QObject *parent = nullptr);
    ~Navigation();
    QGeoRouteReply source() {return source_;}
    QList<QGeoRouteSegment> segments() {return segments_;}
signals:

public slots:

private:
    QGeoRouteReply source_;
    QList<QGeoRouteSegment> segments_;
};

#endif // NAVIGATION_H
