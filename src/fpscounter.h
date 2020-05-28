#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <QTime>

class FPSCounter : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(int fps READ fps NOTIFY fpsChanged)

public:
    FPSCounter(QQuickItem *parent = 0);

    void paint(QPainter *painter);
    int fps() {return fps_;}

signals:
    void fpsChanged(int fps);

private:
    QTime m_time;
    int m_frameCount;
    int fps_;
};
