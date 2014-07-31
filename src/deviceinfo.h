#ifndef DEVICEINFO_H
#define DEVICEINFO_H

#include <QObject>
#include <QSettings>

class DeviceInfo : public QObject
{
    Q_OBJECT
public:
    explicit DeviceInfo(QObject *parent = 0);

    Q_INVOKABLE QVariant sideloading();

signals:
    void packageProgressChanged(QString packageName, int packageProgress);
    void packageStatusChanged(QString packageName, int packageStatus);
    void packageError(QString packageError);

public slots:
    void d_onPackageProgressChanged(QString package, int progress);
    void d_onPackageStatusChanged(QString package, int status);
    void d_onPackageError(QString error);

private:
    QSettings m_settings;

};

#endif // DEVICEINFO_H
