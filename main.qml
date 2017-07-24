import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import AppData 1.0
import DeviceInfo 1.0
import FirebaseObject 1.0

ApplicationWindow {
    id: appWindow
    property alias appWindow: appWindow
    property alias farmData : farmData
    property alias deviceInfo: deviceInfo
    property alias fontRegular: fontRegular
    property alias swipeView: swipeView
    property alias tabBar: tabBar
    property alias optionsMenu: optionsMenu
    property alias quitPopup: quitPopup
    visible: true
    width: 480
    height: 800
    Material.theme: Material.Light
    Material.accent: Material.Grey
    Material.foreground: Material.White
    title: qsTr("Precision Irrigation System")

    FontLoader {id: fontRegular; source: "qrc:/fonts/SuperspaceRegular.ttf"}
    FontLoader {id: fontItalic; source: "qrc:/fonts/SuperspaceLight.ttf"}


    //Component.onCompleted: {
    //    console.log("Screen Orientation = ("+ Screen.primaryOrientation + ")" )
    //}

    /*Item {
        anchors.fill: parent
        focus: true
        Keys.onReleased: {
            if (event.key == Qt.Key_Back) {
                console.log("Back key pressed...");
                if(tabBar.currentIndex != 0)
                {
                    swipeView.currentIndex = 0;
                    tabBar.currentIndex = swipeView.currentIndex;
                    event.accepted = true;
                }
                else
                {
                    quitPopup.open();
                }
                event.accepted = true;
            }
        }
    }*/
    /*Item{
        id: itemKey
        Keys.onPressed: {
            //appWindow.close();
            console.log("Back key button pressed...!")
            if(event.key === Qt.Key_Back)
            {
                event.accepted = true;
                if(tabBar.currentIndex != 0)
                {
                    swipeView.currentIndex = 0;
                    tabBar.currentIndex = swipeView.currentIndex;
                }
                else
                {
                    quitPopup.open();
                }
           }
        }
    }*/
    SlidingMenu{
        id: slidingMenu
    }

    AppData{
        id: farmData
    }

    DeviceInfo{
        id: deviceInfo
    }

    FirebaseObject{
        id: firebaseObject
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        interactive: false

        PageUser{
            id: pageUser
        }

        PageToday {
            id: pageToday
            //enabled: false
        }

        PageFarmDetails{
            id: pageFarmDetails
            //enabled: false
        }

        PageWeatherInfo{
            id: pageWeatherInfo
            //enabled: false
        }

        PageSensorInfo{
            id: pageSensorInfo
            //enabled: false
        }

        PagePlantDetail{
            id: pagePlantDetail
            //enabled: false
        }

        PageAboutUs{
            //id: pageAboutUs
        }

    }

    /*DropShadow {
        anchors.fill: tabBar
        horizontalOffset: 0
        verticalOffset: -2
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: tabBar
    }*/
    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        enabled: false

        TabButton {
            Image{
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: Material.theme ? "images/ic_account_circle_white_18dp.png" : "images/ic_account_circle_black_18dp.png"
            }
        }

        TabButton {
            Image{
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: Material.theme ? "images/ic_dashboard_white_18dp.png" : "images/ic_dashboard_black_18dp.png"
            }
        }
        TabButton {
            Image{
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: Material.theme ? "images/ic_domain_white_18dp.png" : "images/ic_domain_black_18dp.png"
            }

        }
        TabButton {
            Image{
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: Material.theme ? "images/ic_place_white_18dp.png" : "images/ic_place_black_18dp.png"
            }
        }
        TabButton {
            Image{
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: Material.theme ? "/images/ic_router_white_18dp.png" : "/images/ic_router_black_18dp.png"
            }
        }
        TabButton {
            Image{
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: Material.theme ? "images/ic_local_florist_white_18dp.png" : "images/ic_local_florist_black_18dp.png"
            }
        }
        TabButton {
            Image{
                width: 30
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: Material.theme ? "images/ic_group_white_18dp.png" : "images/ic_group_black_18dp.png"
            }
        }

    }

    Menu {
        id: optionsMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight

        /*MenuItem {
            text: "Sign In"
            onTriggered: signInDialog.open()
        }*/

        MenuItem {
            text: "ตั้งค่าควบคุมปั๊มน้ำ"
            font.pixelSize: 16
            font.family: fontRegular.name
            onTriggered: pageToday.dialogPump.open()
        }
        MenuItem {
            text: "About"
            font.pixelSize: 16
            font.family: fontRegular.name
            onTriggered: aboutDialog.open()
        }
    }

    Popup {
        id: signInDialog
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: appWindow.height / 6
        width: Math.min(appWindow.width, appWindow.height) / 4 * 3
        contentHeight: signInColumn.height
        ColumnLayout{
            id: signInColumn
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Label {
                id: label
                width: 480
                height: 30
                text: qsTr("\nSMART IRRIGATION COMPUTING SYSTEM\n")
                font.family: fontRegular.name
                font.pixelSize: 40
                font.bold: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label{
                    text: "Username "
                    font.family: fontRegular.name
                    font.pixelSize: 17
                    font.bold: true
                }

                TextField {
                    id: textFieldEmail
                    height: 40
                    text: qsTr("srikaewa@gmail.com")
                    font.family: fontRegular.name
                    font.pixelSize: 17
                    Layout.minimumWidth: 380
                }

            }

            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label{
                    text: "Password "
                    font.family: fontRegular.name
                    font.pixelSize: 17
                    font.bold: true
                }

                TextField {
                    id: textFieldPassword
                    width: 400
                    height: 40
                    text: qsTr("12345678")
                    echoMode: TextInput.Password
                    font.family: fontRegular.name
                    font.pixelSize: 17
                    Layout.minimumWidth: 380
                }
            }

            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                Button {
                    id: buttonSignIn
                    width: 134
                    height: 40
                    text: "Sign In"
                    font.family: fontRegular.name
                    font.pixelSize: 17
                    flat: true
                }

                Label{
                    text: "       "
                }

                Button {
                    id: buttonSignUp
                    width: 134
                    height: 40
                    text: "Sign Up"
                    font.family: fontRegular.name
                    font.pixelSize: 17
                    flat: true
                }
            }

            Label {
                id: labelUserLoginStatus
                text: "Please sign in to begin using app..."
                font.family: fontRegular.name
                font.pixelSize: 17
                Layout.alignment: Qt.AlignHCenter
            }

            Label{
                text: "\n\n\n\n"
            }

            Row{
                Layout.alignment: Qt.AlignHCenter
                Image {
                    id: image
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/NRCT2.png"
                }

                Image {
                    id: image1
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/nstda.png"
                }

                Image {
                    id: image2
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/sut_logo.png"
                }

                Image {
                    id: image3
                    width: 68
                    height: 85
                    fillMode: Image.PreserveAspectFit
                    source: "images/SunTrust_AI_Logo.png"
                }
            }
        }
    }


    Popup {
        id: aboutDialog
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: appWindow.height / 6
        width: Math.min(appWindow.width, appWindow.height) / 4 * 3
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                text: "About"
                font.bold: true
            }

            Label {
                width: aboutDialog.availableWidth
                text: "ซอฟต์แวร์ประมวลผลการให้น้ำไร่มันสำปะหลัง"
                wrapMode: Label.Wrap
                font.family: fontRegular.name
                font.pixelSize: 17
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Build Number: " + farmData.getBuildNumber() + "\n"
                                    + "- ออกแบบ UI ใหม่แนว Material\n"
                                    + "- ควบคุมปั๊มน้ำหลักพร้อมแสดงกราฟสถานะ\n"
                                    + "- กำหนด channel และ API Key ของปั๊มน้ำได้\n"
                                    + "- ควบคุมวาล์วน้ำพร้อมแสดงกราฟสถานะ\n"
                                    + "- ควบคุมการให้น้ำพร้อม timer และแสดงสถานะการให้น้ำด้วยสี\n"
                                    + "- เพิ่ม multiple farm management\n"
                                    + "- เพิ่ม multiple zone management พร้อมคำนวณขนาดโซนอัตโมัติ\n"
                                    + "- เพิ่ม view สำหรับแสดงผลจากเครือข่ายเซ็นเซอร์ไร้สาย\n"
                                    + "- เพิ่ม 8 Channel สำหรับเครือข่ายเซ็นเซอร์ไร้สาย"
                                    + "- เพิ่ม user authentication"
                                + "To Do:\n"
                                 + "- menu settings\n"
                                + "- Cloud sync\n"
                                + "- Compile for iOS devices\n"
                wrapMode: Label.Wrap
                font.family: fontRegular.name
                font.pixelSize: 17
            }
        }
    }

    Popup {
        id: quitPopup
        x: (appWindow.width - width) / 2
        y: appWindow.height / 2
        width: Math.min(appWindow.width, appWindow.height) / 5 * 4
        height: quitColumn.implicitHeight + topPadding + bottomPadding
        modal: true
        focus: true

        contentItem: ColumnLayout {
            id: quitColumn
            spacing: 20

            Label {
                text: "ต้องการออกจากระบบ?"
                horizontalAlignment: Text.AlignHCenter
                font.family: fontRegular.name
                font.bold: true
            }

            RowLayout {
                spacing: 10

                Button {
                    id: okButton
                    text: "Ok"
                    onClicked: {
                        appWindow.close()
                    }

                }

                Button {
                    id: cancelButton
                    text: "Cancel"
                    onClicked: {
                        quitPopup.close()
                    }
                }
            }
        }
    }

}
