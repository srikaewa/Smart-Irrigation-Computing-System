import QtQuick 2.4
//import QtQuick.Controls.Material 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Item {
    id: itemFarmDetail
    width: 480
    height: 1000
    property alias comboBoxFarmTitle: comboBoxFarmTitle
    property alias textFarmDetailHeader: textFarmDetailHeader
    property alias rectangleFarmDetailHeader: rectangleFarmDetailHeader
    property alias expandableFarmDetailPane: expandableFarmDetailPane
    property alias labelDripPerTape: expandableFarmDetailPane.labelDripPerTape
    // property alias expandableFarmDetailPane: expandableFarmDetailPane
    property alias spinBoxTapeInterval: spinBoxTapeInterval
    property alias spinBoxDripRate: spinBoxDripRate
    property alias spinBoxTapeNumber: spinBoxTapeNumber
    property alias spinBoxDripInterval: spinBoxDripInterval
    property alias spinBoxTapeLength: spinBoxTapeLength
    property alias labelTapeLengthCaption: labelTapeLengthCaption
    //property alias mouseAreaFarmDetailMenu: mouseAreaFarmDetailMenu

    property alias comboBoxSoilType: comboBoxSoilType
    property alias labelHoldingCapacity: labelHoldingCapacity
    property alias labelAllowableWaterDepletion: labelAllowableWaterDepletion
    property alias labelPlantType : labelPlantType

    //property alias expandableCalendarStartDate: expandableCalendarStartDate
    property alias calendarStartDate: calendarStartDate
    property alias labelStopDate: labelStopDate

    property alias listFarmTitle: listFarmTitle

    Pane {
        id: paneBackground
        anchors.fill: parent
    }

    Flickable {
        id: flickableFarmDetail
        boundsBehavior: Flickable.DragAndOvershootBounds
        clip: true
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        contentWidth: parent.width
        contentHeight: 1000

        Rectangle {
            id: rectangleFarmDetailHeader
            y: 0
            height: 30
            color: "#ffad40"
            border.width: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Text {
                id: textFarmDetailHeader
                x: 227
                y: 13
                color: "#000000"
                //text: qsTr("รายละเอียดแปลงเกษตร")
                text: farmData.farmTitle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
            }
        }

        Label {
            id: labelPlantTypeCaption
            x: 22
            y: 87
            text: qsTr("ประเภทของพืช")
            font.family: "Tahoma"
            font.pixelSize: 16
        }
        Label {
            id: labelPlantType
            x: 288
            y: 87
            width: 161
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 20
            font.pixelSize: 16
            text: farmData.plantTitle
        }

        Label {
            id: labelTapeLengthCaption
            x: 22
            y: 133
            text: qsTr("ความยาวเทปน้ำหยด")
            font.family: "Tahoma"
            font.pixelSize: 16
        }

        SpinBox {
            id: spinBoxTapeLength
            x: 243
            y: 37
            width: 130
            height: 40
            anchors.right: labelTapeLengthUnit.left
            anchors.rightMargin: 2
            anchors.verticalCenterOffset: 0
            to: 100
            from: 70
            value: farmData.tapeLength
            anchors.verticalCenter: labelTapeLengthCaption.verticalCenter
        }

        /*ComboBox {
            id: comboBoxPlantType
            x: 288
            y: 81
            width: 161
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 31
            model: ["มันสำปะหลัง","อ้อย"]
            font.pixelSize: 16
        }*/

        Label {
            id: labelTapeLengthUnit
            y: 133
            height: 27
            text: qsTr("เมตร")
            anchors.left: parent.right
            anchors.leftMargin: -60
            font.pixelSize: 16
        }

        Label {
            id: labelDripIntervalCaption
            x: 22
            y: 178
            text: qsTr("ระยะห่างระหว่างหัวน้ำหยด")
            font.family: "Tahoma"
            font.pixelSize: 16
        }

        SpinBox {
            id: spinBoxDripInterval
            x: 200
            y: 124
            width: 130
            anchors.right: labelDripIntervalUnit.left
            anchors.rightMargin: 2
            anchors.verticalCenter: labelDripIntervalCaption.verticalCenter
            from: 1
            value: farmData.dripInterval*to
            to: 1 * 10
            stepSize: 1
            property int decimals: 1;
            property real realValue: value / 100;

            validator: DoubleValidator {
                bottom: Math.min(spinBoxDripInterval.from, spinBoxDripInterval.to)
                top:  Math.max(spinBoxDripInterval.from, spinBoxDripInterval.to)
            }

            textFromValue: function(value, locale) {
                return Number(value / 10).toLocaleString(locale, 'f', spinBoxDripInterval.decimals)
            }

            valueFromText: function(text, locale) {
                return Number.fromLocaleString(locale, text) * 10
            }

        }

        Label {
            id: labelDripIntervalUnit
            y: 178
            text: qsTr("เมตร")
            anchors.left: parent.right
            anchors.leftMargin: -60
            font.pixelSize: 16
        }

        Label {
            id: labelTapeNumberCaption
            x: 22
            y: 223
            height: 27
            text: qsTr("จำนวนเทปน้ำหยด")
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
        }

        SpinBox {
            id: spinBoxTapeNumber
            x: 200
            y: 167
            width: 130
            to: 20
            from: 1
            value: farmData.tapeNumber
            anchors.right: labelTapeNumberUnit.left
            anchors.rightMargin: 2
            anchors.verticalCenter: labelTapeNumberCaption.verticalCenter
        }

        Label {
            id: labelTapeNumberUnit
            y: 223
            height: 27
            text: qsTr("เส้น")
            anchors.left: parent.right
            anchors.leftMargin: -60
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: labelDripRateCaption
            x: 22
            y: 268
            text: qsTr("อัตราไหลต่อหัวน้ำหยด")
            font.pixelSize: 16
        }

        SpinBox {
            id: spinBoxDripRate
            x: 200
            y: 210
            width: 130
            from: 1
            value: farmData.dripRate*10
            to: 1*100
            anchors.right: labelDripRateUnit.left
            anchors.rightMargin: 2
            anchors.verticalCenter: labelDripRateCaption.verticalCenter
            property int decimals: 1
            property real realValue: value / 100

            validator: DoubleValidator {
                bottom: Math.min(spinBoxDripRate.from, spinBoxDripRate.to)
                top:  Math.max(spinBoxDripRate.from, spinBoxDripRate.to)
            }

            textFromValue: function(value, locale) {
                return Number(value / 10).toLocaleString(locale, 'f', spinBoxDripRate.decimals)
            }

            valueFromText: function(text, locale) {
                return Number.fromLocaleString(locale, text) * 10
            }
        }

        Label {
            id: labelDripRateUnit
            y: 268
            height: 27
            text: qsTr("ลิตร/ชม.")
            anchors.left: parent.right
            anchors.leftMargin: -60
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: labelTapeIntervalCaption
            x: 22
            y: 310
            text: qsTr("ระยะห่างระหว่างเทปน้ำหยด")
            font.pixelSize: 16
        }

        SpinBox {
            id: spinBoxTapeInterval
            x: 288
            y: 253
            width: 130
            anchors.verticalCenterOffset: 3
            from: 1
            value: farmData.tapeInterval*10
            to: 1*100
            anchors.right: labelTapeIntervalUnit.left
            anchors.rightMargin: 2
            anchors.verticalCenter: labelTapeIntervalCaption.verticalCenter
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

        }

        Label {
            id: labelTapeIntervalUnit
            y: 310
            height: 27
            text: qsTr("เมตร")
            anchors.left: parent.right
            anchors.leftMargin: -60
            font.pixelSize: 16
        }

        ComboBox {
            id: comboBoxSoilType
            x: 288
            y: 353
            width: 161
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 31
            anchors.verticalCenterOffset: -120
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
            model: ["ทราย","ร่วนปนทราย","ร่วน","ร่วนปนตะกอนทราย","ร่วนปนเหนียวปนตะกอนทราย","เหนียว"]
            currentIndex: farmData.soilId - 1
        }

        Label {
            id: labelSoilTypeCaption
            x: 22
            y: 350
            text: qsTr("ประเภทของดิน")
            font.pixelSize: 16

            Label {
                id: labelHoldingCapacity
                x: 8
                y: 26
                text: qsTr("ดินอุ้มน้ำได้ 1.65 มม./ชม.")
                font.pixelSize: 12
            }

            Label {
                id: labelAllowableWaterDepletion
                x: 8
                y: 46
                text: qsTr("ยอมให้น้ำแก่พืชได้ 50%")
                font.pixelSize: 12
            }
        }

        Label {
            id: labelStartDateCaption
            x: 22
            y: 422
            text: qsTr("วันเริ่มต้นการปลูก")
            font.pixelSize: 16
        }

        Label {
            id: labelStopDateCaption
            x: 22
            y: 659
            text: qsTr("วันสิ้นสุดการปลูก")
            font.pixelSize: 16

        }


        /*ExpandableCalendar {
            id: expandableCalendarStartDate
            x: 165
            y: 433
            anchors.right: parent.right
            anchors.rightMargin: 15
            calendarSelectedDate: farmData.startDate
            //labelSelectedDate: Qt.formatDate(calendar.selectedDate,"ddd, dd MMM, yyyy")
            Label {
                id: labelStopDate
                font.bold: true
                font.pixelSize: 14
                //x: 165
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.rightMargin: 15
                //text: Qt.formatDate(farmData.stopDate,"ddd, dd MMM yyyy");
                text: farmData.stopDate
                anchors.horizontalCenterOffset: 1
                anchors.top: parent.top
                anchors.topMargin: 56
                //labelSelectedDate: Qt.formatDate(calendar.selectedDate,"ddd, dd MMM yyyy")
            }
        }*/

        ExpandableDetailPane {
            id: expandableFarmDetailPane
            x: 10
            y: 692
            paneDetail.visible: false
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
        }

        ComboBox {
            id: comboBoxFarmTitle
            height: 40
            anchors.top: rectangleFarmDetailHeader.bottom
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            displayText: "เลือกแปลงเกษตรจากรายการที่มีอยู่"
            model: listFarmTitle
            ListModel{
                id: listFarmTitle
                ListElement{
                    title: "Precision Farm 1"
                }
                ListElement{
                    title: "Precision Farm 2"
                }
                ListElement{
                    title: "Precision Farm 3"
                }
            }
        }

        Calendar {
            id: calendarStartDate
            x: 185
            y: 449
            width: 200
            height: 204
            visibleMonth: 8
            navigationBarVisible: true
            frameVisible: true
            dayOfWeekFormat: 1
            anchors.horizontalCenterOffset: -5
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

        Label {
            id: labelStopDate
            x: 195
            y: 669
            width: 250
            height: 14
            text: Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy")
            anchors.verticalCenter: labelStopDateCaption.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 35
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        /* ExpandableDetailPane {
            id: expandableFarmDetailPane
            x: 10
            y: 482
            labelHeaderText: "More Details..."
        }*/


    }



    /*    Image {
        id: imageFarmDetailMenu
        x: 8
        y: 0
        width: 38
        height: 40
        source: "images/ic_menu_black_18dp.png"

        MouseArea {
            id: mouseAreaFarmDetailMenu
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
        }
    } */


}
