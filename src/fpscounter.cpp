#include "fpscounter.h"
#include <QTime>
#include <QDebug>
#include <QPainter>

FPSCounter::FPSCounter(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{
}

void FPSCounter::paint(QPainter *painter) {
    if (m_frameCount == 0) {
         m_time.start();
    } else {
        qDebug() << "FPS: " << 1000 / m_time.elapsed();
        m_time.start();
    }
    m_frameCount++;


    update();
}
