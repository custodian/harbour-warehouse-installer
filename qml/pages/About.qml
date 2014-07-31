import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column

            anchors{
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }

            spacing: Theme.paddingLarge
            PageHeader {
                title: "Warehouse Installer"
            }
            Label {
                x: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                text: "About"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/usr/share/icons/hicolor/86x86/apps/harbour-warehouse-installer.png"
            }
            Text {
                width: parent.width
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "Warehouse Installer is a program that assists and guide you through the process of Warehouse installation."
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
            Text {
                width: parent.width
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "After installing Warehouse, you can safely uninstall Warehouse Installer."
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "<a href='#'>Web-site (OpenRepos)</a>";
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally("https://openrepos.net/content/basil/warehouse-sailfishos")
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "<a href='#'>Support forum (Talk Maemo Org)</a>";
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally("http://talk.maemo.org/showthread.php?t=91574")
            }
            /*Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "<a href='#'>Source code (GitHub)</a>";
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally("https://github.com/custodian/harbour-rpminstaller")
            }*/
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                text: "Basil Semuonov 2014"
            }
        }
    }
}


