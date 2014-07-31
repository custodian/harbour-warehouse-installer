#include <QtQuick>

#include <sailfishapp.h>
#include "deviceinfo.h"

int main(int argc, char *argv[])
{
    // SailfishApp::main() will display "qml/template.qml", if you need more
    // control over initialization, you can use:
    //
    //   - SailfishApp::application(int, char *[]) to get the QGuiApplication *
    //   - SailfishApp::createView() to get a new QQuickView * instance
    //   - SailfishApp::pathTo(QString) to get a QUrl to a resource file
    //
    // To display the view, call "show()" (will show fullscreen on device).

    //return SailfishApp::main(argc, argv);

    QGuiApplication *app = SailfishApp::application(argc, argv);

    /*
    QTranslator qtTranslator;
    qtTranslator.load("qt_" + QLocale::system().name(),
                    QLibraryInfo::location(QLibraryInfo::TranslationsPath));
    app->installTranslator(&qtTranslator);
    */

    app->setApplicationName("WarehouseInstaller");
    app->setOrganizationName("Openrepos");

    QQuickView* viewer = SailfishApp::createView();

    // /usr/share/jolla-settings/pages/sideloading/sideloading.qml
    QObject::connect(viewer->engine(), SIGNAL(quit()), app, SLOT(quit()));
    viewer->engine()->addImportPath(QString("/usr/share/jolla-settings/pages/sideloading"));

    DeviceInfo deviceInfo;
    viewer->rootContext()->setContextProperty("deviceInfo", &deviceInfo);

    viewer->setSource(SailfishApp::pathTo("qml/harbour-warehouse-installer.qml"));
    viewer->show();
    return app->exec();
}

