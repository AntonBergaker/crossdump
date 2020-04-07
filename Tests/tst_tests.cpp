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
    // from polacks to stationen
    NavigationTask* task = navigator->Navigate(QGeoCoordinate(59.841, 17.649),
                        QGeoCoordinate(59.859, 17.646));



    QSignalSpy spy(task, SIGNAL(resultChanged(Navigation*)));

    spy.wait(20000);

    QCOMPARE(spy.count(), 1);
    QList<QVariant> arguments = spy.takeFirst();
    Navigation* result = qvariant_cast<Navigation*>(arguments.at(0));

    // Make sure the result has at least 5 segments with driving instructions
    QVERIFY(result->segments().count() >= 5);

    for (QGeoRouteSegment* segment: result->segments())
    {
        QGeoManeuver maneuver = segment->maneuver();
        QVERIFY(maneuver.instructionText().length() > 0);
    }

    delete result;
    delete task;
    delete navigator;
}



QTEST_MAIN(Tests)

#include "tst_tests.moc"
