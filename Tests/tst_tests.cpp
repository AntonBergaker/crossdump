#include <QtTest>
#include <stdlib.h>
#include "../src/navigator.h"
#include "../src/navigationtask.h"
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
    void test_navigator();

};

Tests::Tests()
{

}

Tests::~Tests()
{

}

void Tests::test_navigator()
{
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



QTEST_MAIN(Tests)

#include "tst_tests.moc"
