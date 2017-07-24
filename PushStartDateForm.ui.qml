import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Item {
    id: item1
    width: 480
    height: 800
    anchors.fill: parent

    property alias calendarStartDate: calendarStartDate
    property alias labelStartDate: labelStartDate
    property alias labelStopDate: labelStopDate
    property alias mouseAreaStartDateBack: mouseAreaStartDateBack

    Pane {
        id: paneBackground
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Label {
            id: labelStartDateCaption
            y: 381
            text: qsTr("วันที่เริ่มปลูก")
            anchors.left: parent.left
            anchors.leftMargin: 10
            font.pixelSize: 17
            font.family: fontRegular.name
        }

        Label {
            id: labelStopDateCaption
            x: -1
            text: qsTr("วันสิ้นสุดการปลูก")
            anchors.top: labelStartDateCaption.bottom
            anchors.topMargin: 10
            font.pixelSize: 17
            font.family: fontRegular.name
            anchors.leftMargin: 10
            anchors.left: parent.left
        }

        Label {
            id: labelStartDate
            x: 3
            y: 381
            //text: Qt.formatDate(calendarStartDate.selectedDate,"ddd, MMM dd, yyyy")
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: labelStartDateCaption.verticalCenter
            font.pixelSize: 17
            font.family: fontRegular.name
        }

        Label {
            id: labelStopDate
            x: 261
            y: 423
            //text: Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy")
            font.pixelSize: 17
            font.family: fontRegular.name
            anchors.verticalCenter: labelStopDateCaption.verticalCenter
            anchors.rightMargin: 10
            anchors.right: parent.right
        }
    }

    Rectangle {
        id: rectangleFarmDetailHeader
        y: 0
        height: 30
        color: "#EEEEEE"
        border.width: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Label {
            id: textFarmDetailHeader
            x: 227
            y: 13
            color: "#000000"
            text: "วันที่เริ่มปลูก"
            //text: qsTr("รายละเอียดแปลงเกษตร")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            font.family: fontRegular.name
        }

        Image {
            id: imageArrowBack
            x: 0
            y: 0
            width: 30
            height: 30
            source: "images/ic_keyboard_arrow_left_white_18dp.png"

            MouseArea {
                id: mouseAreaStartDateBack
                anchors.fill: parent
            }
        }
    }

    Calendar {
        id: calendarStartDate
        x: 185
        width: 460
        height: 334
        anchors.top: rectangleFarmDetailHeader.bottom
        anchors.topMargin: 10
        visibleMonth: 8
        navigationBarVisible: true
        frameVisible: true
        dayOfWeekFormat: 1
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        antialiasing: true
        weekNumbersVisible: true
        selectedDate: farmData.startDate
        style: CalendarStyle {
                       gridVisible: false
                       dayDelegate: Rectangle {
                           gradient: Gradient {
                               GradientStop {
                                   position: 0.00
                                   color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
                               }
                               GradientStop {
                                   position: 1.00
                                   color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                               }
                               GradientStop {
                                   position: 1.00
                                   color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                               }
                           }


                           Label {
                               text: styleData.date.getDate()
                               anchors.centerIn: parent
                               color: styleData.valid ? "white" : "grey"
                           }

                           Rectangle {
                               width: parent.width
                               height: 1
                               color: "#555"
                               anchors.bottom: parent.bottom
                           }

                           Rectangle {
                               width: 1
                               height: parent.height
                               color: "#555"
                               anchors.right: parent.right
                           }
                       }
                   }

    }

}
