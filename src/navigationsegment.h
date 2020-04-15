#ifndef NAVIGATIONSEGMENT_H
#define NAVIGATIONSEGMENT_H

#include <QObject>
#include <QtLocation/QGeoRouteSegment>
#include <QDebug>

// A small segment of a navigation, usually the size of a road before you need to take action with
// your vechicle, like turning onto another road
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
