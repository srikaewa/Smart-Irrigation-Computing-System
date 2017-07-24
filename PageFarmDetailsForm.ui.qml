import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

StackView {
    id: stackViewFarmDetails
    initialItem: itemFarmDetails
    width: 480
    height: 800
    property alias busyIndicatorFarmDetail: busyIndicatorFarmDetail
    property alias waterCalculationGridLayout: waterCalculationGridLayout
    property alias comboBoxSelectFarm: comboBoxSelectFarm
    property alias cbFarmItems: cbFarmItems
    property alias labelFarmDetailHeader: labelFarmDetailHeader
    property alias labelZoneTitle: labelZoneTitle
    property alias labelWaterInGroundPerHour: labelWaterInGroundPerHour
    property alias labelFlowRateTotal: labelFlowRateTotal
    property alias labelMaxFlowRate: labelMaxFlowRate
    property alias labelDripTotal: labelDripTotal
    property alias labelDripPerTape: labelDripPerTape

    property alias labelAreaWidth: labelAreaWidth
    property alias labelAreaLength: labelAreaLength
    property alias labelPEDiameter: labelPEDiameter
    property alias labelTapeInterval: labelTapeInterval
    property alias labelTapeNumber: labelTapeNumber
    property alias labelDripFlowRate: labelDripFlowRate
    property alias labelDripInterval: labelDripInterval
    property alias labelTapeLength: labelTapeLength
    property alias labelSoilType: labelSoilType
    property alias labelStartDate: labelStartDate
    property alias labelStopDate: labelStopDate

    property alias mouseAreaImageEditFarm: mouseAreaImageEditFarm
    property alias mouseAreaImageAddFarm: mouseAreaImageAddFarm
    property alias mouseAreaImageDeleteFarm: mouseAreaImageDeleteFarm

    property alias mouseAreaAreaWidth: mouseAreaAreaWidth
    property alias mouseAreaAreaLength: mouseAreaAreaLength
    property alias mouseAreaDripInterval: mouseAreaDripInterval
    property alias mouseAreaPEDiameter: mouseAreaPEDiameter
    property alias mouseAreaDripFlowRate: mouseAreaDripFlowRate
    property alias mouseAreaTapeInterval: mouseAreaTapeInterval
    property alias mouseAreaSoilType: mouseAreaSoilType
    property alias mouseAreaStartDate: mouseAreaStartDate

    property alias imageAreaWidthRightArrow: imageAreaWidthRightArrow
    //property alias mouseAreaTapeLength: mouseAreaTapeLength
    property alias stackViewFarmDetails: stackViewFarmDetails

    property bool changeFarm: true

    Item {
        id: itemFarmDetails
        anchors.fill: parent

        BusyIndicator{
            id: busyIndicatorFarmDetail
            width: 150
            height: 150
            anchors.centerIn: parent
            running: false
        }

        Rectangle {
            id: paneDetail
            anchors.top: rectangleFarmDetailHeader.bottom
            anchors.topMargin: 0
            width: parent.width
            visible: true
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            color: "#eeeeeeee"

            DropShadow {
                anchors.fill: rectangleFarmTitle
                horizontalOffset: 1
                verticalOffset: 1
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: rectangleFarmTitle
            }

            Rectangle{
                id: rectangleFarmTitle
                color: "#ffffffff"
                radius: 2
                anchors.top: parent.top
                anchors.topMargin: 16
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width/2 - 32 : 16)
                height: 50

                    ComboBox {
                        id: comboBoxSelectFarm
                        x: 10
                        height: 40
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 130
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        textRole: "farmTitle"
                        model: cbFarmItems
                        flat: true
                        //textRole: "description"
                        //onCurrentIndexChanged: hereMap.activeMapType = hereMap.supportedMapTypes[currentIndex]
                        font.family: fontRegular.name
                        font.pixelSize: 17
                        Image {
                            id: imageEditFarm
                            width: 30
                            height: 30
                            source: Material.theme ? "images/ic_mode_edit_white_18dp.png" : "/images/ic_mode_edit_black_18dp.png"
                            anchors.left: parent.right
                            anchors.leftMargin: 10
                            MouseArea {
                                id: mouseAreaImageEditFarm
                                anchors.fill: parent
                            }
                        }

                        Image {
                            id: imageAddFarm
                            width: 30
                            height: 30
                            source: Material.theme ? "images/ic_add_circle_outline_white_18dp.png" : "/images/ic_add_circle_black_18dp.png"
                            anchors.left: imageEditFarm.right
                            anchors.leftMargin: 10
                            MouseArea {
                                id: mouseAreaImageAddFarm
                                anchors.fill: parent
                            }
                        }
                        Image {
                            id: imageDeleteFarm
                            width: 30
                            height: 30
                            source: Material.theme ? "images/ic_delete_black_18dp.png" : "/images/ic_delete_black_18dp.png"
                            anchors.left: imageAddFarm.right
                            anchors.leftMargin: 10
                            MouseArea {
                                id: mouseAreaImageDeleteFarm
                                anchors.fill: parent
                            }
                        }
                    }

            }
            ListModel {
                id: cbFarmItems
                ListElement {
                    farmId: 0
                    farmTitle: "Banana"
                }
                ListElement {
                    farmId: 1
                    farmTitle: "apple"
                }
                ListElement {
                    farmId: 2
                    farmTitle: "kiwi"
                }
            }



            DropShadow {
                anchors.fill: rectangleDetailBody
                horizontalOffset: 1
                verticalOffset: 1
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: rectangleDetailBody
            }

            Rectangle {
                id: rectangleDetailBody
                color: "#ffffffff"
                radius: 2
                anchors.top: rectangleFarmTitle.bottom
                anchors.topMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width/2 - 32 : 16)
                anchors.left: parent.left
                anchors.leftMargin: 16
                //height: labelTapeLengthCaption.height * 20
                anchors.bottom: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.bottom : parent.top)
                anchors.bottomMargin: (Screen.primaryOrientation == Qt.LandscapeOrientation ? 16: - labelTapeLengthCaption.height * 23)

                GridLayout{
                    id: waterCalculationGridLayout
                    columns: 3
                    flow: GridLayout.LeftToRight
                    anchors.margins: 16
                    anchors.fill: parent
                    Label{
                        id: labelZoneTitle
                        text: "รายละเอียดพื้นที่โซน (กว้าง x ยาว = " + farmData.zoneWidth.toFixed(1) + " เมตร x " + farmData.zoneLength.toFixed(1) + " เมตร) จากทั้งหมด "+farmData.getZoneTotal()+" โซน";
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 :  availableHeight * 0.018)
                        font.family: fontRegular.name
                        font.bold: true
                        Layout.columnSpan: 3
                    }

                    Column{
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: labelTapeLengthCaption
                            text: qsTr("ความยาวเทปน้ำหยด")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }
                        Label {
                            id: labelTapeLengthDetail
                            Layout.columnSpan: 3
                            text: qsTr("ความยาวเทปน้ำหยดสูงสุด 100 เมตร")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.02 : availableHeight * 0.014)
                            font.family: fontItalic.name
                        }
                    }
                    Label {
                        id: labelTapeLength
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        text: qsTr("50")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelTapeLengthUnit
                        Layout.alignment: Qt.AlignTop
                        text: qsTr("เมตร")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }

                    Column{
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: labelDripPerTapeCaption
                            text: qsTr("จำนวนหัวน้ำหยดต่อเทป 1 เส้น")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }
                        Label {
                            id: labelDripPerTapeDetail
                            Layout.columnSpan: 3
                            text: qsTr("ความยาวเทปน้ำหยด/ระยะห่างระหว่างหัวน้ำหยด")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.02 : availableHeight * 0.014)
                            font.family: fontItalic.name
                        }
                    }
                    Label {
                        id: labelDripPerTape
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        text: qsTr("260")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelDripPerTapeUnit
                        Layout.alignment: Qt.AlignTop
                        text: qsTr("หัว")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }

                    Column{
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: labelTapeNumberCaption
                            text: qsTr("จำนวนเทปน้ำหยด")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }
                        Label {
                            id: labelTapeNumberDetail
                            Layout.columnSpan: 3
                            text: qsTr("ความยาวพื้นที่/ระยะห่างระหว่างเทปน้ำหยด")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.02 : availableHeight * 0.014)
                            font.family: fontItalic.name
                        }
                    }
                    Label {
                        id: labelTapeNumber
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        text: qsTr("67")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelTapeNumberUnit
                        Layout.alignment: Qt.AlignTop
                        text: qsTr("เส้น")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }

                    Column{
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: labelDripTotalCaption
                            text: qsTr("จำนวนหัวน้ำหยดทั้งหมด")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }
                        Label {
                            id: labelDripTotalDetail
                            Layout.columnSpan: 3
                            text: qsTr("จำนวนเทปทั้งหมด x จำนวนหัวน้ำหยดต่อเทป")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.02 : availableHeight * 0.014)
                            font.family: fontItalic.name
                        }
                    }
                    Label {
                        id: labelDripTotal
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        text: qsTr("2080")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelDripTotalUnit
                        Layout.alignment: Qt.AlignTop
                        text: qsTr("หัว/พท.")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }

                    Column{
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: labelFlowRateTotalCaption
                            text: qsTr("อัตราการไหลของน้ำเข้าโซน")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }
                        Label {
                            id: labelFlowRateTotalDetail
                            Layout.columnSpan: 3
                            text: qsTr("อัตราการไหลต่อหัวน้ำหยด x จำนวนหัวหยดทั้งหมด")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.02 : availableHeight * 0.014)
                            font.family: fontItalic.name
                        }
                    }
                    Label {
                        id: labelFlowRateTotal
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        text: qsTr("5200")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelFlowRateTotalUnit
                        Layout.alignment: Qt.AlignTop
                        text: qsTr("ลิตร/ชม.")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }

                    Column{
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: labelMaxFlowRateCaption
                            text: qsTr("อัตราการไหลในท่อ PE สูงสุด")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }
                        Label {
                            id: labelMaxFlowRateDetail
                            Layout.columnSpan: 3
                            text: qsTr("ตามขนาดของท่อ PE")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.02 : availableHeight * 0.014)
                            font.family: fontItalic.name
                        }
                    }
                    Label {
                        id: labelMaxFlowRate
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        text: qsTr("5200")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelMaxFlowRateUnit
                        Layout.alignment: Qt.AlignTop
                        text: qsTr("ลิตร/ชม.")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }

                    Column{
                        Layout.alignment: Qt.AlignTop
                        Label {
                            id: labelWaterInGroundPerHourCaption
                            text: qsTr("ความสูงของน้ำในดินต่อ 1 ชม.")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                            font.family: fontRegular.name
                        }
                        Label {
                            id: labelWaterInGroundPerHourDetail
                            Layout.columnSpan: 3
                            text: qsTr("อัตราการไหลของน้ำเข้าต่อพื้นที่")
                            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.02 : availableHeight * 0.014)
                            font.family: fontItalic.name
                        }
                    }
                    Label {
                        id: labelWaterInGroundPerHour
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        text: qsTr("7.9365")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelWaterInGroundPerHourUnit
                        Layout.alignment: Qt.AlignTop
                        text: qsTr("มม./ชม.")
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.018)
                        font.family: fontRegular.name
                    }

                }
            }

        Rectangle{
            id: rectangleParameterBody
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.top : rectangleDetailBody.bottom)
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: (Screen.primaryOrientation == Qt.LandscapeOrientation ? rectangleDetailBody.right : parent.left)
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 16
            color: "#eeeeeeee"
            //color: "#ff123456"
        Flickable {
            id: flickableFarmDetails
            clip: true
            anchors.fill: parent
            contentHeight: 800
            boundsBehavior: Flickable.DragAndOvershootBounds
            GridLayout{
                id: farmParameterGridLayout
                columns: 5
                flow: GridLayout.LeftToRight
                anchors.margins: 0
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: 16
                //anchors.fill: parent

            Label {
                id: labelAreaWidthCaption
                text: qsTr("ความกว้างของพื้นที่")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

                Label {
                    id: labelAreaWidth
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight
                    //text: qsTr("78")
                    text: farmData.areaWidth
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                    font.family: fontRegular.name
                }
            Label {
                id: labelAreaWidthUnit
                text: qsTr("เมตร")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Image {
                id: imageAreaWidthRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaAreaWidth
                    anchors.fill: parent
                }
            }

            Label {
                id: labelAreaLengthCaption
                text: qsTr("ความยาวของพื้นที่")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Label {
                id: labelAreaLength
                //text: "8"
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                text: farmData.areaLength
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Label {
                id: labelAreaLengthUnit
                text: qsTr("เมตร")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Image {
                id: imageAreaLengthrRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaAreaLength
                    anchors.fill: parent
                }
            }

            Label {
                id: labelDripIntervalCaption
                text: qsTr("ระยะห่างระหว่างหัวน้ำหยด")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Label {
                id: labelDripInterval
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                font.family: fontRegular.name
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
            }
            Label {
                id: labelDripIntervalUnit
                text: qsTr("เมตร")
                font.family: fontRegular.name
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
            }
            Image {
                id: imageDripIntervalRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaDripInterval
                    anchors.fill: parent
                }
            }

            Label {
                id: labelDripFlowRateCaption
                text: qsTr("อัตราไหลต่อหัวน้ำหยด")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Label {
                id: labelDripFlowRate
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Label {
                id: labelDripFlowRateUnit
                text: qsTr("ลิตร/ชม.")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Image {
                id: imageDripFlowRateRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaDripFlowRate
                    anchors.fill: parent
                }
            }

            Label {
                id: labelTapeIntervalCaption
                text: qsTr("ระยะห่างระหว่างเทปน้ำหยด")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

            Label {
                id: labelTapeInterval
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                font.family: fontRegular.name
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
            }

            Label {
                id: labelTapeIntervalUnit
                text: qsTr("เมตร")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

            Image {
                id: imageTapeIntervalRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaTapeInterval
                    anchors.fill: parent
                }
            }

            Label {
                id: labelPEDiameterCaption
                text: qsTr("ขนาดท่อ PE")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

            Label {
                id: labelPEDiameter
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                font.family: fontRegular.name
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
            }

            Label {
                id: labelPEDiameterlUnit
                text: qsTr("มิลลิเมตร")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

            Image {
                id: imagePEDiameterRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaPEDiameter
                    anchors.fill: parent
                }
            }

            Label {
                id: labelSoilTypeCaption
                text: qsTr("ประเภทของดิน")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

            Label {
                id: labelSoilType
                Layout.columnSpan: 3
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                //text: qsTr("ร่วนปนทราย")
                text: farmData.soilTitle
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }
            Image {
                id: imageSoilTypeRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaSoilType
                    anchors.fill: parent
                }
            }

            Label {
                id: labelStartDateCaption
                text: qsTr("วันที่เริ่มปลูก")
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

            Label {
                id: labelStartDate
                Layout.columnSpan: 3
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                text: Qt.formatDate(farmData.startDate,"ddd, MMM dd, yyyy");
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.025 : availableHeight * 0.014)
                font.family: fontRegular.name
            }

            Image {
                id: imageStartDateRightArrow
                sourceSize.width: 25
                height: sourceSize.width
                source: "images/ic_keyboard_arrow_right_black_18dp.png"
                MouseArea {
                    id: mouseAreaStartDate
                    anchors.fill: parent
                }
            }

            Label {
                id: labelStopDateCaption
                text: qsTr("วันสิ้นสุดการปลูก")
                font.italic: true
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.022 : availableHeight * 0.012)
                font.family: fontRegular.name
            }

            Label {
                id: labelStopDate
                Layout.columnSpan: 4
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                text: Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy");
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.022 : availableHeight * 0.012)
                font.family: fontRegular.name
            }
        }
        }
        }
    }
        DropShadow {
            anchors.fill: rectangleFarmDetailHeader
            horizontalOffset: 0
            verticalOffset: 1
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: rectangleFarmDetailHeader
        }

        Rectangle {
            id: rectangleFarmDetailHeader
            y: 0
            height: availableHeight * 0.15
            //color: "#FFCC80"
            border.width: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Image {
                id: imageCasavaHeader
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: "images/CassavaHeader.png"

                Label {
                    id: labelFarmDetailHeader
                    x: 133
                    y: -1
                    color: "#ffffffff"
                    text: "รายละเอียดแปลงเกษตร"
                    fontSizeMode: Text.HorizontalFit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: 0
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.height * 0.4 : parent.height * 0.2)
                    font.family: fontRegular.name
                    font.bold: true
                }
            }
        }
    }
}
