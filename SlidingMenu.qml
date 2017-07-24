import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Item {
    id: itemDrawer
    property alias drawer: drawer
    property alias textUserName: textUserName
    width: 480
    height: 800
    anchors.fill: parent

    Drawer {
        id: drawer
        width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? 0.3 * itemDrawer.width : 0.66 * itemDrawer.width)
        //width: imageFarmDetail.width + textFarmDetail.width + 30
        height: itemDrawer.height
        dragMargin: 0

    ColumnLayout{
        spacing: 20
    Pane {
        id: rectangleUserName
        Layout.preferredHeight: 100
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter

        Image {
            id: imageUserAvatar
            width: 50
            height: 50
            anchors.top: parent.top
            anchors.topMargin: 10
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            source: Material.theme ? "images/ic_account_circle_white_18dp.png" : "images/ic_account_circle_black_18dp.png"

            Label {
                id: textUserName
                text: qsTr("Anonymous")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -20
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: fontRegular.name
                font.pixelSize: 17
                font.bold: true
            }

            MouseArea {
                id: mouseUserName
                anchors.fill: parent
                onClicked: {
                    drawer.visible = false;
                    tabBar.setCurrentIndex(0);
                }
            }
        }
    }

    Pane {
        id: rectangleWateringToday
        Layout.preferredHeight: 50
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter
        Image {
            id: imageWateringToday
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: Material.theme ? "images/ic_dashboard_white_18dp.png" : "images/ic_dashboard_black_18dp.png"

            Label {
                id: textWateringToday
                text: qsTr("ตารางการให้น้ำวันนี้")
                anchors.left: parent.right
                font.family: fontRegular.name
                font.pixelSize: 17
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        MouseArea {
            id: mouseAreaWateringToday
            anchors.fill: parent
            onClicked: {
                drawer.visible = false;
                tabBar.setCurrentIndex(1);
            }
        }
    }

    Pane {
        id: rectangleFarmDetail
        Layout.preferredHeight: 50
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter
        Image {
            id: imageFarmDetail
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: textFarmDetail
                text: qsTr("รายละเอียดแปลงเกษตร")
                anchors.left: parent.right
                font.family: fontRegular.name
                font.pixelSize: 17
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            source: Material.theme ? "images/ic_domain_white_18dp.png" : "images/ic_domain_black_18dp.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            id: mouseAreaFarmDetail
            anchors.fill: parent
            onClicked: {
                drawer.visible = false;
                tabBar.setCurrentIndex(2);
            }

        }
        anchors.right: parent.right
    }

    Pane {
        id: rectangleFarmLocation
        Layout.preferredHeight: 50
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter
        Image {
            id: imageFarmLocation
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: textFarmLocation
                text: qsTr("ตำแหน่งแปลงเกษตร")
                anchors.left: parent.right
                font.family: fontRegular.name
                font.pixelSize: 17
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            source: Material.theme ? "images/ic_place_white_18dp.png" : "images/ic_place_black_18dp.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            id: mouseAreaFarmLocation
            anchors.fill: parent
            onClicked: {
                drawer.visible = false;
                tabBar.setCurrentIndex(3);
            }

        }
        anchors.right: parent.right
    }

    Pane {
        id: rectangleSensorDetail
        Layout.preferredHeight: 50
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter
        Image {
            id: imageSensorDetail
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: textSensorDetail
                text: qsTr("ข้อมูลเครือข่ายเซ็นเซอร์ไร้สาย")
                anchors.left: parent.right
                font.family: fontRegular.name
                font.pixelSize: 17
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            source: Material.theme ? "/images/ic_router_white_18dp.png" : "/images/ic_router_black_18dp.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            id: mouseAreaSensorDetail
            anchors.fill: parent
            onClicked: {
                drawer.visible = false;
                tabBar.setCurrentIndex(4);
            }

        }
        anchors.right: parent.right
    }

    Pane {
        id: rectanglePlantDetail
        Layout.preferredHeight: 50
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter
        Image {
            id: imagePlantDetail
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: textPlantDetail
                text: qsTr("รายละเอียดพืช")
                anchors.left: parent.right
                font.family: fontRegular.name
                font.pixelSize: 17
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            source: Material.theme ? "images/ic_local_florist_white_18dp.png" : "images/ic_local_florist_black_18dp.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            id: mouseAreaPlantDetail
            anchors.fill: parent
            onClicked: {
                drawer.visible = false;
                tabBar.setCurrentIndex(5);
            }

        }
        anchors.right: parent.right
    }

    Pane {
        id: rectangleAboutUs
        Layout.preferredHeight: 50
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter
        Image {
            id: imageAboutUs
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: textAboutUs
                text: qsTr("เกี่ยวกับเรา")
                anchors.left: parent.right
                font.family: fontRegular.name
                font.pixelSize: 17
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            source: Material.theme ? "images/ic_group_white_18dp.png" : "images/ic_group_black_18dp.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            id: mouseAreaAboutUs
            anchors.fill: parent
            onClicked: {
                drawer.visible = false;
                tabBar.setCurrentIndex(6);
            }

        }
        anchors.right: parent.right
    }

    Pane {
        id: rectangleExit
        Layout.preferredHeight: 50
        Layout.preferredWidth: drawer.width
        Layout.alignment: Qt.AlignCenter
        Image {
            id: imageExit
            width: 30
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            Label {
                id: textExit
                text: qsTr("ออกจากระบบ")
                anchors.left: parent.right
                font.family: fontRegular.name
                font.pixelSize: 17
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            source: Material.theme ? "images/ic_exit_to_app_white_18dp.png" : "images/ic_exit_to_app_black_18dp.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            id: mouseAreaExit
            anchors.fill: parent
            onClicked: {
                Qt.quit()
            }

        }
    }

   }
}
}
