#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <QTime>

class FPSCounter : public QQuickPaintedItem
{
    Q_OBJECT

public:
    FPSCounter(QQuickItem *parent = 0);

    void paint(QPainter *painter);

private:
    QTime m_time;
    int m_frameCount;
};
