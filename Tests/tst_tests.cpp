#include <QtTest>
#include <stdlib.h>
#include "../src/navigator.h"
#include "../src/navigationtask.h"
#include "../src/collisionhelper.h"
#include <QDebug>
#include <QSignalSpy>
#include <QGeoRouteSegment>
#include <QGeoManeuver>
#include <vector>

// add necessary includes here

class Tests : public QObject
{
    Q_OBJECT

public:
    Tests();
    ~Tests();

private slots:
    void test_navigator() {
        Navigator* navigator = new Navigator();
        NavigationTask* task  = new NavigationTask();
        // from polacks to stationen
        navigator->navigateWithStartEnd(task, QGeoCoordinate(59.841, 17.649),
                            QGeoCoordinate(59.859, 17.646));



        QSignalSpy spy(task, SIGNAL(resultChanged(Navigation*)));

        spy.wait(20000);

        QCOMPARE(spy.count(), 1);
        QList<QVariant> arguments = spy.takeFirst();
        Navigation* result = qvariant_cast<Navigation*>(arguments.at(0));

        QList<NavigationSegment*> segments = result->segments();

        int count = segments.size();

        QVERIFY(count >= 5);

        delete result;
        delete task;
        delete navigator;
    }

    void test_circle_collision() {
        CollisionHelper::Point cO = CollisionHelper::Point(5, 5);

        // Center of circle
        QVERIFY(CollisionHelper::CirclePointCollision(cO, 5, CollisionHelper::Point(5, 5)));

        // Edge of circle
        QVERIFY(CollisionHelper::CirclePointCollision(cO, 5, CollisionHelper::Point(9.9, 5)));

        // Outside of circle
        QVERIFY(CollisionHelper::CirclePointCollision(cO, 5, CollisionHelper::Point(10.01, 5)) == false);

        // Edge vertical
        QVERIFY(CollisionHelper::CirclePointCollision(cO, 5, CollisionHelper::Point(5+3.52, 5+3.52)));

        // Outside vertical
        QVERIFY(CollisionHelper::CirclePointCollision(cO, 5, CollisionHelper::Point(5+3.54, 5+3.54)) == false);
    }

    void test_line_point_collision() {
        CollisionHelper::Point p0 = CollisionHelper::Point(5, 5);
        CollisionHelper::Point p1 = CollisionHelper::Point(10, 10);

        QVERIFY(CollisionHelper::LinePointCollision(p0, p1, CollisionHelper::Point(7, 7)));

        QVERIFY(CollisionHelper::LinePointCollision(p0, p1, CollisionHelper::Point(8, 7)) == false);
    }

    void test_line_circle_collision() {
        CollisionHelper::Point cO = CollisionHelper::Point(5, 5);

        // Line through middle of circle with edges outside
        QVERIFY(CollisionHelper::CircleLineCollision(cO, 5, CollisionHelper::Point(-5, 5), CollisionHelper::Point(15, 5)));

        // Line through middle of circle with edges inside
        QVERIFY(CollisionHelper::CircleLineCollision(cO, 5, CollisionHelper::Point(1, 5), CollisionHelper::Point(9, 5)));

        // Line over circle
        QVERIFY(CollisionHelper::CircleLineCollision(cO, 5, CollisionHelper::Point(0, 11), CollisionHelper::Point(10, 11)) == false);
    }

    void test_point_polygon_collision() {
        std::vector<CollisionHelper::Point> points = std::vector<CollisionHelper::Point>();

        points.push_back(CollisionHelper::Point(-1, -5));
        points.push_back(CollisionHelper::Point(5, -1));
        points.push_back(CollisionHelper::Point(3, 3));
        points.push_back(CollisionHelper::Point(-2, 5));
        points.push_back(CollisionHelper::Point(-5, 1));

        QVERIFY(CollisionHelper::PointInPolygon(CollisionHelper::Point(0, 0), points));
        QVERIFY(CollisionHelper::PointInPolygon(CollisionHelper::Point(1, 1), points));
        QVERIFY(CollisionHelper::PointInPolygon(CollisionHelper::Point(-1, -1), points));
        QVERIFY(CollisionHelper::PointInPolygon(CollisionHelper::Point(3, -2), points));

        QVERIFY(CollisionHelper::PointInPolygon(CollisionHelper::Point(4, -4), points) == false);
        QVERIFY(CollisionHelper::PointInPolygon(CollisionHelper::Point(0, -5), points) == false);

        // The exact one we have on the map that returns true (fixed but test stays)
        points.clear();

        points.push_back(CollisionHelper::Point(59.8702 , 17.6277));
        points.push_back(CollisionHelper::Point(59.8712 , 17.6167));
        points.push_back(CollisionHelper::Point(59.8785 , 17.6184));
        points.push_back(CollisionHelper::Point(59.875 , 17.6312 ));
        points.push_back(CollisionHelper::Point(59.8717 , 17.6327));


        CollisionHelper::Point point = CollisionHelper::Point(59.86 , 17.6279);

        QVERIFY(CollisionHelper::PointInPolygon(point, points) == false);
    }
};

Tests::Tests()
{

}

Tests::~Tests()
{

}


QTEST_MAIN(Tests)

#include "tst_tests.moc"
