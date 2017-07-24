import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtWebView 1.1

Item {
    id: item1
    width: 480
    height: 800
    property alias mouseAreaPumpInfoBack: mouseAreaPumpInfoBack
    Pane {
        id: paneBackground
        anchors.fill: parent

       // WebView {
            //anchors.left: parent.left
            //anchors.leftMargin: 5
            //anchors.right: parent.right
            //anchors.rightMargin: 5
            //anchors.top: labelPumpInfo.bottom
            //anchors.topMargin: 5
            //anchors.bottom: parent.bottom
            //anchors.bottomMargin: 5
       //     anchors.fill: parent
       //     url: "https://thingspeak.com/channels/173378/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line"
       // }


        Rectangle {
            id: rectanglePumpInfoHeader
            y: -12
            height: 30
            color: "#EEEEEE"
            border.width: 0
            anchors.right: parent.right
            anchors.rightMargin: -12
            anchors.left: parent.left
            anchors.leftMargin: -12

            Label {
                id: textPumpInfoHeader
                x: 227
                y: 13
                width: 480
                height: 30
                color: "#000000"
                text: "สถานะเปิดปิดของปั๊มน้ำ"
                horizontalAlignment: Text.AlignHCenter
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
                source: Material.theme ? "qrc:/images/ic_keyboard_arrow_left_white_18dp.png" : "qrc:/images/ic_keyboard_arrow_left_black_18dp.png"

                MouseArea {
                    id: mouseAreaPumpInfoBack
                    anchors.fill: parent

                }
            }



        }

        Label {
            id: labelPumpInfo
            x: 172
            text: qsTr("ปั๊มเปิด = 0, ปั๊มปิด = 1")
            anchors.top: rectanglePumpInfoHeader.bottom
            anchors.topMargin: 15
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: rectanglePumpInfoHeader.horizontalCenter
            font.pixelSize: 14
            font.family: fontRegular.name
        }
    }
}

