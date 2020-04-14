#ifndef NAVIGATIONSEGMENT_H
#define NAVIGATIONSEGMENT_H

#include <QObject>
#include <QtLocation/QGeoRouteSegment>
#include <QDebug>

class NavigationSegment  : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString instructionText READ instructionText CONSTANT)
public:
    explicit NavigationSegment(QObject *parent = nullptr);
    explicit NavigationSegment(QGeoRouteSegment* segment, QObject *parent = nullptr);
    ~NavigationSegment();
    QString instructionText() {return instructionText_;}

private:
    QString instructionText_;
};


#endif // NAVIGATIONSEGMENT_H
