import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
//import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Item {
    width: 480
    height: 800
    anchors.fill: parent
    Pane {
        id: paneBackground
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Label {
            id: labelHoldingCapacityCaption
            y: 127
            text: qsTr("ดินอุ้มน้ำได้")
            anchors.bottom: labelAllowableWaterDepletionCaption.top
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 60
            font.pixelSize: 17
            font.family: fontRegular.name
        }

        Label {
            id: labelAllowableWaterDepletionCaption
            y: 211
            text: qsTr("ยอมให้น้ำแก่พืชได้")
            anchors.bottom: tumblerSoilType.top
            anchors.bottomMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 60
            font.pixelSize: 17
            font.family: fontRegular.name
        }

        Label {
            id: labelHoldingCapacityUnit
            x: 6
            y: 127
            text: qsTr("มม./ชม.")            
            anchors.verticalCenter: labelHoldingCapacityCaption.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 60
            font.pixelSize: 17
            font.family: fontRegular.name
        }

        Label {
            id: labelHoldingCapacity
            x: 3
            y: 127
            text: qsTr("1.65")
            font.family: fontRegular.name
            anchors.right: labelHoldingCapacityUnit.left
            anchors.rightMargin: 10
            anchors.verticalCenter: labelHoldingCapacityCaption.verticalCenter
            font.pixelSize: 17
        }

        Label {
            id: labelAllowableWaterDepletionUnit
            x: 335
            y: 211
            text: qsTr("%")
            font.pixelSize: 17
            font.family: fontRegular.name
            anchors.verticalCenter: labelAllowableWaterDepletionCaption.verticalCenter
            anchors.rightMargin: 60
            anchors.right: parent.right
        }

        Label {
            id: labelAllowableWaterDepletion
            x: 350
            y: 215
            text: qsTr("50")
            font.pixelSize: 17
            font.family: fontRegular.name
            anchors.verticalCenter: labelAllowableWaterDepletionCaption.verticalCenter
            anchors.rightMargin: 10
            anchors.right: labelAllowableWaterDepletionUnit.left
        }

        Tumbler {
            id: tumblerSoilType
            y: 288
            height: 200
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 60
            anchors.left: parent.left
            anchors.leftMargin: 60
            model: ["ดินทราย","ดินร่วนปนทราย","ดินร่วน","ดินร่วนปนตะกอนทราย","ดินร่วนปนเหนียวปนตะกอนทราย","ดินเหนียว"]
            currentIndex: farmData.soilId - 1
            onCurrentIndexChanged: {
                farmData.soilId = tumblerSoilType.currentIndex + 1
                farmData.readSoilInfo();
                labelHoldingCapacity.text = farmData.holdingCapacity.toFixed(2);
                labelAllowableWaterDepletion.text = farmData.allowableWaterDepletion.toString();
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
            text: "ประเภทของดิน"
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
                id: mouseAreaSoilTypeBack
                anchors.fill: parent
                onClicked: {                    
                    labelSoilType.text = tumblerSoilType.model[tumblerSoilType.currentIndex];
                    tabBar.visible = true;
                    stackViewFarmDetails.pop();
                }
            }
        }
    }
}
