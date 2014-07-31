import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property string packagePath: Qt.resolvedUrl("../../data/harbour-warehouse-0.3-19.armv7hl.rpm")
    onPackagePathChanged: {
        console.log("PackagePath", packagePath);
    }

    property bool sideloadingEnabled: false
    property bool installing: false
    property int progressPercent: 0



    function updateSideloading() {
        sideloadingEnabled = deviceInfo.sideloading();
    }

    property int stackDepth: pageStack.depth
    onStackDepthChanged: {
        updateSideloading();
    }

    property bool appActive: Qt.application.active
    onAppActiveChanged: {
        console.log("Application active:", appActive);
        if (appActive) {
            updateSideloading();
        }
    }

    Connections {
        target: deviceInfo
        onPackageProgressChanged: {
            if (packagePath.indexOf(packageName)>0) {
                progressPercent = packageProgress
            }
        }
        onPackageStatusChanged: {
            if(packagePath.indexOf(packageName)>0) {
                if (packageStatus == 1) {
                    console.log("Warehouse installed, exiting...");
                    installing = false;
                    Qt.quit();
                } else if (packageStatus == 2) {
                    installing = true;
                } else {
                    installing = false;
                }
            }
        }
        onPackageError: {
            installing = false;
            console.log("Error occured:", packageError);
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        Column {
            id: column
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }

            PageHeader {
                title: qsTr("Warehouse Installer")
            }
            Column {
                width: parent.width

                Column {
                    visible: !sideloadingEnabled
                    width: parent.width

                    spacing: Theme.paddingLarge

                    Text {
                        width: parent.width
                        color: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeMedium
                        text: "In order to install Warehouse, you have to enable installation of \"Untrusted Software\" at your device settings."
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }

                    Button {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Open Settings"
                        onClicked: {
                            pageStack.push(/*deviceInfo.sideloadingDialog*/"/usr/share/jolla-settings/pages/sideloading/sideloading.qml");
                        }
                    }
                }

                Column {
                    visible: sideloadingEnabled
                    width: parent.width

                    spacing: Theme.paddingLarge

                    Text {
                        width: parent.width
                        color: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeMedium
                        text: "You can proceed with Warehouse installation. SailfishOS default interface for package installation will be opened."
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        width: parent.width
                        color: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeMedium
                        text: "When process will be finished, Warehouse Installer will uninstall itself."
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }

                    Button {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Install Warehouse"
                        enabled: !installing
                        onClicked: {
                            installing = true;
                            Qt.openUrlExternally(packagePath);
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: Theme.paddingLarge

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: Theme.primaryColor
                            text: "Installing: %1%".arg(progressPercent)
                        }

                        ProgressBar {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.8
                            minimumValue: 0
                            maximumValue: 100
                            value: progressPercent
                        }

                        visible: installing
                    }
                }
            }
        }
    }
}


