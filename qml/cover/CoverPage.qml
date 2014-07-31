import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Column {
        anchors.centerIn: parent
        width: parent.width
        spacing: Theme.paddingMedium

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "/usr/share/icons/hicolor/86x86/apps/harbour-warehouse-installer.png"
        }
        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            text: "Warehouse Installer"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }
}


