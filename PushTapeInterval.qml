import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Item {
    width: 480
    height: 800
    property alias mouseAreaTapeIntervalBack: mouseAreaTapeIntervalBack
    Pane {
        id: paneBackground
        anchors.fill: parent

        Image {
            id: imageTapeInterval
            x: 69
            y: 61
            width: 318
            height: 177
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "images/TapeInterval.png"
        }

        SpinBox {
            id: spinBoxTapeInterval
            x: 158
            y: 259
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: fontRegular.name
            from: 1
            value: farmData.tapeInterval*10
            to: 1*100
            property int decimals: 1
            property real realValue: value / to

            validator: DoubleValidator {
                bottom: Math.min(spinBoxTapeInterval.from, spinBoxTapeInterval.to)
                top:  Math.max(spinBoxTapeInterval.from, spinBoxTapeInterval.to)
            }

            textFromValue: function(value, locale) {
                return Number(value / 10).toLocaleString(locale, 'f', spinBoxTapeInterval.decimals)
            }

            valueFromText: function(text, locale) {
                return Number.fromLocaleString(locale, text) * 10
            }


            Label {
                id: labelTapeIntervalUnit
                y: 6
                text: qsTr("เมตร")
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
            text: "ระยะห่างระหว่างเทปน้ำหยด"
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
                id: mouseAreaTapeIntervalBack
                anchors.fill: parent
                onClicked: {
                    farmData.tapeInterval = (spinBoxTapeInterval.value/10);
                    labelTapeInterval.text = (spinBoxTapeInterval.value/10).toFixed(1);
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
