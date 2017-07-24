import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

StackView {
    id: stackViewToday
    initialItem: itemToday
    width: 480
    height: 1400
    property alias todayFarmTitle: todayFarmTitle
    //property alias comboBoxTodaySelectFarm: comboBoxTodaySelectFarm
    //property alias cbTodayFarmItems: cbTodayFarmItems
    property alias mouseAreaMenuOption: mouseAreaMenuOption
    property alias stackViewToday: stackViewToday
    //property alias mouseAreaPumpInfo: mouseAreaPumpInfo
    //property alias labelPumpOnTimer: labelPumpOnTimer
    //property alias switchPump: switchPump
    property alias listModelNextWatering: listModelNextWatering
    property alias listViewNextWatering: listViewNextWatering
    property alias rectangleTodayWatering: rectangleTodayWatering
    property alias labelToday: labelToday
    property alias labelCurrentDate: labelCurrentDate
    property alias labelTodayWatering: labelTodayWatering
    property alias labelTodayDate: labelTodayDate
    property alias flickableToday: flickableToday
    property alias labelPullDown: labelPullDown
    property alias busyIndicatorWateringUpdate: busyIndicatorWateringUpdate
    property alias gridZoneRectangle: gridZoneRectangle
    property alias labelZoneCaption: labelZoneCaption
    property alias repeaterZone: repeaterZone
    property alias imageMenu: imageMenu


    //property alias mouseAreaValveTimer: mouseAreaValveTimer
    //property alias switchValve: switchValve
    Item {
        id: itemToday

        Label {
            id: labelPullDown
            anchors.horizontalCenter: parent.horizontalCenter
            y: availableHeight * 0.15
            text: "Pull down to refresh..."
            font.family: fontRegular.name
        }

        Rectangle {
            id: paneBackground
            x: 0
            y: 0
            color: "#eeeeeeee"
            anchors.fill: parent
        }

        Flickable {
            id: flickableToday
            height: availableHeight * 2
            boundsBehavior: Flickable.DragAndOvershootBounds
            clip: true
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: availableHeight * 0.15
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            contentWidth: parent.width
            contentHeight: (Screen.primaryOrientation
                            == Qt.LandscapeOrientation ? availableHeight
                                                         * 1.5 : availableHeight * 1.5)

            DropShadow {
                anchors.fill: rectangleTodayBody
                horizontalOffset: 1
                verticalOffset: 1
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: rectangleTodayBody
            }

            Rectangle {
                id: rectangleTodayBody
                width: (Screen.primaryOrientation
                        == Qt.LandscapeOrientation ? (appWindow.width / 2) - 15 : parent.width - 20)
                height: 200
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: "#ffffffff"
                radius: 2
                Label {
                    id: todayFarmTitle
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    font.family: fontRegular.name
                    font.bold: true
                    font.pixelSize: 22
                    text: "Farm Title"
                }
                Rectangle {
                    id: rectangleTodayHeaderBox
                    anchors.top: todayFarmTitle.bottom
                    anchors.topMargin: 0
                    width: rectangleTodayBody.width
                    height: rectangleTodayBody.height * 0.18
                    radius: 2
                    Label {
                        id: labelCurrentDate
                        text: qsTr("Today")
                        font.bold: true
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        anchors.top: parent.top
                        anchors.topMargin: 16
                    }

                    Label {
                        id: labelToday
                        text: qsTr("ตารางให้น้ำวันนี้")
                        font.bold: true
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                        anchors.right: parent.right
                        anchors.rightMargin: 16
                        anchors.top: parent.top
                        anchors.topMargin: 16
                    }
                }
                Rectangle {
                    id: rectangleTodayPumpBox
                    width: parent.width
                    anchors.top: rectangleTodayHeaderBox.bottom
                    anchors.topMargin: 10
                    anchors.bottom: parent.bottom
                    color: "#ffffffff"
                    radius: 2
                    Rectangle {
                        id: rectangleTodayWatering
                        width: 25
                        height: 80
                        color: "#ffffffff"
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        Label {
                            id: labelTodayDate
                            x: 18
                            y: 8
                            //text: Qt.formatDate(farmData.startDate,"ddd, dd MMM yyyy")
                            text: qsTr("ไม่มี")
                            anchors.left: rectangleTodayWatering.right
                            anchors.leftMargin: 10
                            font.bold: false
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }

                        Label {
                            id: labelTodayWatering
                            x: 18
                            y: 42
                            text: qsTr("ไม่มี")
                            anchors.left: rectangleTodayWatering.right
                            anchors.leftMargin: 10
                            font.bold: false
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.020 : availableHeight * 0.015)
                            font.family: fontRegular.name
                        }
                    }

                    /*                        Button {
                            id: switchPump
                            text: qsTr("ปั๊มน้ำปิด")
                            font.family: fontRegular.name
                            checked: false
                            checkable: true
                            flat: true
                            enabled: true
                            anchors.right: parent.right
                            anchors.rightMargin: 45
                            anchors.top: parent.top
                            anchors.topMargin: 16
                            Label {
                                id: labelPumpOnTimer
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: switchPump.bottom
                                text: qsTr("00:00:00")
                                font.family: fontRegular.name
                                font.pixelSize: 16
                                MouseArea{
                                    id: mouseAreaPumpInfo
                                    anchors.fill: parent
                                }
                            }
                        } */

                    /*Image {
                            id: imagePumpInfo
                            width: 22
                            height: 22
                            source: Material.theme ? "images/ic_info_outline_white_18dp.png" : "images/ic_info_outline_black_18dp.png"
                            anchors.right: parent.right
                            anchors.rightMargin: 16
                            anchors.verticalCenter: switchPump.verticalCenter
                            MouseArea {
                                id: mouseAreaPumpInfo
                                anchors.fill: parent
                            }
                        }*/
                    /*Image {
                            id: imageTodayAlarm
                            width: 22
                            height: 22
                            source: Material.theme ? "images/ic_alarm_on_white_18dp.png" : "images/ic_alarm_off_black_18dp.png"
                            anchors.left: imagePumpInfo.left
                            //anchors.top: parent.top
                            //anchors.topMargin: 16
                            anchors.top: imagePumpInfo.bottom
                            anchors.topMargin: 10
                        }*/
                    //BusyIndicator{
                    //    width: rectangleTodayPumpBox / 4
                    //    height: rectangleTodayPumpBox / 4
                    //    anchors.centerIn: parent
                    //}
                }
            }

            DropShadow {
                anchors.fill: rectangleZoneBody
                horizontalOffset: 1
                verticalOffset: 1
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: rectangleZoneBody
            }

            Rectangle {
                id: rectangleZoneBody

                //x: (deviceInfo.getDeviceType()==0 ? (Screen.primaryOrientation == Qt.LandscapeOrientation ? rectangleTodayBody.width + 20: 10) : 10)
                width: (deviceInfo.getDeviceType(
                            ) == 0 ? rectangleTodayBody.width : parent.width - 20)
                height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? (appWindow.height) - rectangleTodayHeader.height - tabBar.height - 20 : availableHeight * 0.8 - rectangleTodayBody.height - 16)
                anchors.top: (deviceInfo.getDeviceType(
                                  ) == 0 ? (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.top : rectangleTodayBody.bottom) : rectangleTodayBody.bottom)
                anchors.topMargin: 10
                anchors.left: (deviceInfo.getDeviceType(
                                   ) == 0 ? (Screen.primaryOrientation == Qt.LandscapeOrientation ? rectangleTodayBody.right : parent.left) : parent.left)
                anchors.leftMargin: 10
                color: "#ffffffff"
                radius: 2
                Label {
                    id: labelZoneCaption
                    text: "โซนการให้น้ำ"
                    font.bold: true
                    font.pixelSize: (Screen.primaryOrientation
                                     == Qt.LandscapeOrientation ? availableHeight
                                                                  * 0.024 : availableHeight * 0.017)
                    font.family: fontRegular.name
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.top: parent.top
                    anchors.topMargin: 8
                }
                Grid {
                    id: gridZoneRectangle
                    anchors.centerIn: parent
                    layoutDirection: Qt.LeftToRight
                    columns: farmData.getZoneX()
                    rows: farmData.getZoneY()
                    spacing: 2
                    Repeater {
                        id: repeaterZone
                        model: gridZoneRectangle.columns * gridZoneRectangle.rows
                        delegate: Rectangle {
                            id: rectangleZone
                            property alias labelValveOnTimer: labelValveOnTimer
                            property alias switchValve: switchValve
                            width: rectangleZoneBody.width * 0.9 / gridZoneRectangle.columns
                            height: rectangleZoneBody.height * 0.85 / gridZoneRectangle.rows
                            color: Qt.hsla(0, 1.0, 0.5, 0.5)

                            MouseArea {
                                id: mouseAreaValveTimer
                                anchors.fill: parent
                                onClicked: {
                                    switch (index) {
                                    case 0:
                                        pageToday.getValveData1()
                                        pageToday.dialogValve1Status.open()
                                        break
                                    case 1:
                                        pageToday.getValveData2()
                                        pageToday.dialogValve2Status.open()
                                        break
                                    case 2:
                                        break
                                    case 3:
                                        break
                                    }
                                }
                            }

                            //indexTimer: index
                            Timer {
                                id: timerValveRepeater
                                interval: 1000
                                running: false
                                repeat: true
                                property int secCount: farmData.minutesToWater[farmData.currentWatering] * 60
                                onTriggered: {
                                    //console.log("Timer of valve["+index+"] is running!")
                                    //console.log("Time left for valve on -> "+new Date(secCount * 1000).toISOString().substr(11, 8));
                                    if (secCount >= 0) {
                                        labelValveOnTimer.text
                                                = new Date(secCount * 1000).toISOString(
                                                    ).substr(11, 8)
                                        if ((secCount % 60) == 0) {
                                            var perc
                                            perc = (1 / 3) - (secCount / (180 * farmData.minutesToWater[farmData.currentWatering]))
                                            //console.log("Percent color -> "+perc.toString());
                                            rectangleZone.color = Qt.hsla(perc,
                                                                          1.0,
                                                                          0.5)
                                        }
                                        secCount--
                                    } else {
                                        switchValve.checked = false
                                        switchValve.text = "วาล์วน้ำโซน " + (index + 1) + " ปิด"
                                        buttonReset.enabled = true
                                        running = false
                                    }
                                }
                            }

                            Column {
                                id: columnSwitch
                                anchors.centerIn: parent
                                Button {
                                    id: switchValve
                                    text: "วาล์วน้ำโซน " + (index + 1) + " ปิด"
                                    font.family: fontRegular.name
                                    checked: false
                                    checkable: true
                                    flat: true
                                    width: rectangleZone.width * 0.8
                                    enabled: (farmData.todayWateringTime == "ไม่มี" ? false : true)
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    onClicked: {
                                        if (switchValve.checked) {
                                            timerValveRepeater.start()
                                            switchValve.text = "วาล์วน้ำโซน "
                                                    + (index + 1) + " เปิด"
                                            if (farmData.keepScreenOn == 0) {
                                                farmData.KeepScreenOn(true)
                                            }
                                            farmData.keepScreenOn++
                                            buttonReset.enabled = false

                                            function dialResponse() {
                                                console.log(this.responseText) //should be return value of 1
                                            }

                                            // turn on valve #1 and #2
                                            switch (index) {
                                            case 0:
                                                var oReq = new XMLHttpRequest()
                                                oReq.onload = dialResponse
                                                var http_str = "https://api.thingspeak.com/update?api_key=" + textFieldPumpAPIKey.text + "&amp;field3=1"
                                                console.log(http_str)
                                                oReq.open("get", http_str, true)
                                                oReq.send()
                                                break
                                            case 1:
                                                var oReq = new XMLHttpRequest()
                                                oReq.onload = dialResponse
                                                var http_str = "https://api.thingspeak.com/update?api_key=" + textFieldPumpAPIKey.text + "&amp;field4=1"
                                                console.log(http_str)
                                                oReq.open("get", http_str, true)
                                                oReq.send()
                                                break
                                            }
                                        } else {
                                            timerValveRepeater.stop()
                                            switchValve.text = "วาล์วน้ำโซน " + (index + 1) + " ปิด"
                                            if (farmData.keepScreenOn == 1) {
                                                farmData.KeepScreenOn(false)
                                            }
                                            farmData.keepScreenOn--
                                            buttonReset.enabled = true
                                            switch (index) {
                                            case 0:
                                                var oReq = new XMLHttpRequest()
                                                oReq.onload = dialResponse
                                                var http_str = "https://api.thingspeak.com/update?api_key=" + textFieldPumpAPIKey.text + "&amp;field3=-1"
                                                console.log(http_str)
                                                oReq.open("get", http_str, true)
                                                oReq.send()
                                                break
                                            case 1:
                                                var oReq = new XMLHttpRequest()
                                                oReq.onload = dialResponse
                                                var http_str = "https://api.thingspeak.com/update?api_key=" + textFieldPumpAPIKey.text + "&amp;field4=-1"
                                                console.log(http_str)
                                                oReq.open("get", http_str, true)
                                                oReq.send()
                                                break
                                            }
                                        }
                                    }
                                }

                                Label {
                                    id: labelValveOnTimer
                                    text: new Date(timerValveRepeater.secCount * 1000).toISOString(
                                              ).substr(11, 8)
                                    anchors.horizontalCenter: switchValve.horizontalCenter
                                    font.family: fontRegular.name
                                    font.pixelSize: 16
                                }
                                Button {
                                    id: buttonReset
                                    anchors.horizontalCenter: switchValve.horizontalCenter
                                    text: "เริ่มใหม่"
                                    font.family: fontRegular.name
                                    font.pixelSize: 16
                                    flat: true
                                    onClicked: {
                                        timerValveRepeater.secCount = farmData.minutesToWater[farmData.currentWatering] * 60
                                        labelValveOnTimer.text
                                                = new Date(timerValveRepeater.secCount
                                                           * 1000).toISOString(
                                                    ).substr(11, 8)
                                        rectangleZone.color = Qt.hsla(0, 1.0,
                                                                      0.5, 0.5)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            DropShadow {
                anchors.fill: rectangleNextDayBody
                horizontalOffset: 1
                verticalOffset: 1
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: rectangleNextDayBody
            }

            Rectangle {
                id: rectangleNextDayBody
                width: rectangleTodayBody.width
                height: (deviceInfo.getDeviceType(
                             ) == 0 ? appWindow.height - rectangleTodayBody.height
                                      - rectangleTodayHeader.height - tabBar.height
                                      - 30 : (Screen.primaryOrientation == Qt.LandscapeOrientation ? rectangleTodayBody.height : rectangleTodayBody.height * 2))
                anchors.top: (deviceInfo.getDeviceType(
                                  ) == 0 ? (Screen.primaryOrientation == Qt.LandscapeOrientation ? rectangleTodayBody.bottom : rectangleZoneBody.bottom) : (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.top : rectangleZoneBody.bottom))
                anchors.topMargin: 10
                anchors.left: (deviceInfo.getDeviceType(
                                   ) == 0 ? parent.left : (Screen.primaryOrientation == Qt.LandscapeOrientation ? rectangleTodayBody.right : parent.left))
                anchors.leftMargin: 10
                //anchors.bottom: parent.bottom
                //anchors.bottomMargin: 20
                color: "#ffffffff"
                radius: 2

                Label {
                    id: labelNextDay
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    text: qsTr("ตารางให้น้ำครั้งต่อไป")
                    anchors.right: parent.right
                    anchors.rightMargin: 16

                    font.bold: true
                    font.pixelSize: (Screen.primaryOrientation
                                     == Qt.LandscapeOrientation ? availableHeight
                                                                  * 0.025 : availableHeight * 0.018)
                    font.family: fontRegular.name
                }

                ListView {
                    id: listViewNextWatering
                    x: 20
                    y: 49
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 16
                    clip: true
                    anchors.top: labelNextDay.bottom
                    anchors.topMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    model: ListModel {
                        id: listModelNextWatering
                        ListElement {
                            wateringDate: "Sat, Jan 20, 2016"
                            wateringTime: "เปิดน้ำ 2 ชั่วโมง 23 นาที"
                            colorDate: "grey"
                        }

                        ListElement {
                            wateringDate: "Sun, Feb 23, 2016"
                            wateringTime: "เปิดน้ำ - ชั่วโมง 53 นาที"
                            colorDate: "green"
                        }
                    }
                    delegate: Item {
                        x: 5
                        width: 400
                        height: 80
                        //anchors.top: parent.top
                        // anchors.topMargin: 5
                        //anchors.left: parent.left
                        //anchors.leftMargin: 15
                        Column {
                            Row {
                                id: row1
                                spacing: 10
                                Rectangle {
                                    width: 20
                                    height: 70
                                    color: colorDate
                                }
                                Column {
                                    Label {
                                        text: " "
                                        font.pixelSize: 5
                                        font.family: fontRegular.name
                                    }

                                    Label {
                                        text: wateringDate
                                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.020 : availableHeight * 0.015)
                                        font.family: fontRegular.name
                                        //font.bold: true
                                        //anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Label {
                                        text: " "
                                        font.pixelSize: 10
                                        font.family: fontRegular.name
                                    }

                                    Label {
                                        text: wateringTime
                                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.020 : availableHeight * 0.015)
                                        font.family: fontRegular.name
                                        //anchors
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        BusyIndicator {
            id: busyIndicatorWateringUpdate
            width: parent.height / 8
            height: parent.height / 8
            anchors.centerIn: parent
            running: false
        }

        DropShadow {
            anchors.fill: rectangleTodayHeader
            horizontalOffset: 0
            verticalOffset: 1
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: rectangleTodayHeader
        }

        Rectangle {
            id: rectangleTodayHeader
            y: 0
            height: availableHeight * 0.15
            //color: Material.color(Material.Orange)
            //color: Material.theme ? "#FF9800" : "#FFCC80"
            border.width: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Image {
                id: imageCasavaHeader
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: "images/CassavaHeader.png"
                Image {
                    id: imageNRCTLogo
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.height: parent.height * 0.75
                    //fillMode: Image.PreserveAspectCrop
                    source: "images/NRCT2.png"
                    visible: (Screen.primaryOrientation == Qt.LandscapeOrientation ? true : false)
                }
                Image {
                    id: imageNSTDALogo
                    anchors.left: imageNRCTLogo.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.height: parent.height * 0.3
                    //fillMode: Image.PreserveAspectCrop
                    source: "images/nstda.png"
                    visible: (Screen.primaryOrientation == Qt.LandscapeOrientation ? true : false)
                }
                Image {
                    id: imageSUTLogo
                    anchors.left: imageNSTDALogo.right
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.height: parent.height * 0.75
                    //fillMode: Image.PreserveAspectCrop
                    source: "images/sut_logo.png"
                    visible: (Screen.primaryOrientation == Qt.LandscapeOrientation ? true : false)
                }
            }

            Text {
                id: textTodayHeader
                color: "#ffffff"
                text: qsTr("Smart Irrigation Computing System")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? parent.height
                                                              * 0.4 : parent.height * 0.2)
                font.bold: true
                font.family: fontRegular.name
            }

            Image {
                id: imageMenu
                width: 30
                height: 30
                anchors.verticalCenter: textTodayHeader.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 16
                source: Material.theme ? "images/ic_more_vert_black_18dp.png" : "images/ic_more_vert_white_18dp.png"

                MouseArea {
                    id: mouseAreaMenuOption
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.fill: parent
                }
            }
        }
    }
}
