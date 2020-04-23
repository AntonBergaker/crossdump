#include <QtTest>
#include <stdlib.h>
#include "../src/navigator.h"
#include "../src/navigationtask.h"
#include "../src/collisionhelper.h"
#include <QDebug>
#include <QSignalSpy>
#include <QGeoRouteSegment>
#include <QGeoManeuver>

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

        QQmlListProperty<NavigationSegment> segments = result->segments();

        int count = segments.count(&segments);

        QVERIFY(count >= 5);

        for (int i=0; i < count; i++)
        {
            NavigationSegment* segment = segments.at(&segments, i);
            QVERIFY(segment->instructionText() != "");
        }

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
};

Tests::Tests()
{

}

Tests::~Tests()
{

}


QTEST_MAIN(Tests)

#include "tst_tests.moc"
