#include "deviceinfo.h"

#include <QDebug>
#include <QStringList>
#include <QtDBus/QDBusConnection>

/*
signal path=/StoreClient; interface=com.jolla.jollastore; member=packageProgressChanged
  string "filename.rpm"
  int32 progress (0-100)

signal path=/StoreClient; interface=com.jolla.jollastore; member=packageStatusChanged
  string "filename.rpm"
  int32 0 (not installed?), 1 (installed?) and 2 (progressing?)

signal path=/StoreClient; interface=com.jolla.jollastore; member=packageError
  string "details"
*/

#define STORE_SERVICE   "com.jolla.jollastore"
#define STORE_PATH      "/StoreClient"
#define STORE_IFACE     "com.jolla.jollastore"

DeviceInfo::DeviceInfo(QObject *parent) :
    QObject(parent)
    , m_settings("/usr/share/lipstick/devicelock/devicelock_settings.conf", QSettings::IniFormat)
{
    m_settings.beginGroup("desktop");

    QDBusConnection bus = QDBusConnection::sessionBus();
    qDebug() << "DBus System Connection: " << bus.isConnected();
    qDebug() << "DBus PackageKit transactionListChanged connected" <<
    bus.connect(STORE_SERVICE, STORE_PATH, STORE_IFACE, "packageProgressChanged", this, SLOT(d_onPackageProgressChanged(QString, int)));
    qDebug() << "DBus PackageKit updatesChanged connected" <<
    bus.connect(STORE_SERVICE, STORE_PATH, STORE_IFACE, "packageStatusChanged", this, SLOT(d_onPackageStatusChanged(QString, int)));
    qDebug() << "DBus PackageKit repoListChanged connect" <<
    bus.connect(STORE_SERVICE, STORE_PATH, STORE_IFACE, "packageError", this, SLOT(d_onPackageError(QString)));
}

QVariant DeviceInfo::sideloading()
{
    m_settings.sync();
    return m_settings.value("nemo/devicelock/sideloading_allowed", 0).toBool();
}

void DeviceInfo::d_onPackageProgressChanged(QString packageName, int progress)
{
    qDebug() << "packageProgressChanged" << packageName << progress;
    emit packageProgressChanged(packageName, progress);
}

void DeviceInfo::d_onPackageStatusChanged(QString packageName, int status)
{
    qDebug() << "packageStatusChanged" << packageName << status;
    emit packageStatusChanged(packageName,status);
}

void DeviceInfo::d_onPackageError(QString error)
{
    qDebug() << "packageError" << error;
    emit packageError(error);
}
