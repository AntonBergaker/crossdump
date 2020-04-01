#include <QtTest>
#include <stdlib.h>
#include "../src/point.h"

// add necessary includes here

class Tests : public QObject
{
    Q_OBJECT

public:
    Tests();
    ~Tests();

private slots:
    void test_point_distance();

};

Tests::Tests()
{

}

Tests::~Tests()
{

}

void Tests::test_point_distance()
{
    Point a = Point(5, 10);
    Point b = Point(5, 15);

    // Expected from https://www.geodatasource.com/distance-calculator
    double expected = 553830;
    double actual = Point::Distance(a, b);

    // Check accuracy within 100m
    QVERIFY(abs(expected - actual) < 100);
}

QTEST_APPLESS_MAIN(Tests)

#include "tst_tests.moc"
