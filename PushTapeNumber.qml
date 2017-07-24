import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Item {
    width: 480
    height: 800
    property alias mouseAreaTapeNumberBack: mouseAreaTapeNumberBack
    Pane {
        id: paneBackground
        anchors.fill: parent

        Image {
            id: imageTapeNumber
            x: 69
            y: 61
            width: 318
            height: 177
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "images/TapeNumber.png"
        }

        SpinBox {
            id: spinBoxTapeNumber
            x: 158
            y: 259
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: fontRegular.name
            to: 20
            from: 1
            value: farmData.tapeNumber

            Label {
                id: labelTapeNumberUnit
                y: 6
                text: qsTr("เส้น")
                anchors.left: parent.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 17
                font.family: fontRegular.name
            }
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
            text: "จำนวนเทปน้ำหยด"
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
                id: mouseAreaTapeNumberBack
                anchors.fill: parent
                onClicked: {
                    farmData.tapeNumber = spinBoxTapeNumber.value;
                    labelTapeNumber.text = spinBoxTapeNumber.value;
                    labelDripPerTape.text = farmData.dripPerTape.toString();
                    labelDripTotal.text = farmData.dripTotal.toString();
                    labelFlowRateTotal.text = farmData.flowRateTotal.toString();
                    labelWaterInGroundPerHour.text = Math.round(farmData.waterInGroundPerHour*10000)/10000;
                    pageToday.updateTodayWateringList();
                    tabBar.visible = true;
                    stackViewFarmDetails.pop();
                }
            }
        }
    }
}
