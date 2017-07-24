#ifndef DEVICEINFO_H
#define DEVICEINFO_H

#include <QGuiApplication>
#include <QObject>
#include <QScreen>

class DeviceInfo : public QObject
{
    Q_OBJECT
public:
    explicit DeviceInfo(QObject *parent = 0);
    QPointF m_physicalSize;
    int m_deviceType;

    Q_INVOKABLE int getDeviceType();
    Q_INVOKABLE QPointF getPhysicalSize();

signals:

public slots:
};

#endif // DEVICEINFO_H
