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
        fps_ = 1000 / m_time.elapsed();
        emit fpsChanged(fps_);
        qDebug() << "FPS: " << fps_;
        m_time.start();
    }
    m_frameCount++;


    update();
}
