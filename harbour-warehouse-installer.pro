# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-warehouse-installer

CONFIG += sailfishapp

QT += dbus

data.files = data
data.path = $$INSTALL_ROOT/usr/share/harbour-warehouse-installer
INSTALLS += data

SOURCES += src/harbour-warehouse-installer.cpp \
    src/deviceinfo.cpp

OTHER_FILES += qml/harbour-warehouse-installer.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/About.qml \
    rpm/harbour-warehouse-installer.changes.in \
    rpm/harbour-warehouse-installer.spec \
    rpm/harbour-warehouse-installer.yaml \
    translations/*.ts \
    harbour-warehouse-installer.desktop

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-warehouse-installer.ts

HEADERS += \
    src/deviceinfo.h

