#include "deviceinfo.h"

DeviceInfo::DeviceInfo(QObject *parent) : QObject(parent)
{
    QScreen *deviceInfo = QGuiApplication::primaryScreen();
    m_physicalSize.setX(deviceInfo->physicalSize().width());
    m_physicalSize.setY(deviceInfo->physicalSize().height());
    if((m_physicalSize.x()*m_physicalSize.x() + m_physicalSize.y()*m_physicalSize.y()) > 22500)
    {
        m_deviceType = 0; // tablet class
    }
    else
    {
        m_deviceType = 1; // phone class
    }
}

QPointF DeviceInfo::getPhysicalSize()
{
    return m_physicalSize;
}

int DeviceInfo::getDeviceType()
{
    return m_deviceType;
}
