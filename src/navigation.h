#ifndef NAVIGATION_H
#define NAVIGATION_H

#include <QObject>
#include <QtLocation/QGeoRouteReply>

class Navigation : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoRouteReply* source READ source CONSTANT)
public:
    explicit Navigation(QObject *parent = nullptr);
    QGeoRouteReply* source() {return source_;}
signals:

public slots:

private:
    QGeoRouteReply* source_;
};

#endif // NAVIGATION_H
