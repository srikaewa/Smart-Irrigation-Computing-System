import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
//import QtWebView 1.1
import QtCharts 2.0
import Qt.labs.settings 1.0

StackView {
    width: 480
    height: 800

    property alias lineSeriesSensor1: lineSeriesSensor1
    property alias chartViewSensor1: chartViewSensor1
    property alias valueAxisXSensor1: valueAxisXSensor1
    property alias valueAxisYSensor1: valueAxisYSensor1
    property alias lineSeriesSensor2: lineSeriesSensor2
    property alias chartViewSensor2: chartViewSensor2
    property alias valueAxisXSensor2: valueAxisXSensor2
    property alias valueAxisYSensor2: valueAxisYSensor2
    property alias lineSeriesSensor3: lineSeriesSensor3
    property alias chartViewSensor3: chartViewSensor3
    property alias valueAxisXSensor3: valueAxisXSensor3
    property alias valueAxisYSensor3: valueAxisYSensor3
    property alias lineSeriesSensor4: lineSeriesSensor4
    property alias chartViewSensor4: chartViewSensor4
    property alias valueAxisXSensor4: valueAxisXSensor4
    property alias valueAxisYSensor4: valueAxisYSensor4
    property alias lineSeriesSensor5: lineSeriesSensor5
    property alias chartViewSensor5: chartViewSensor5
    property alias valueAxisXSensor5: valueAxisXSensor5
    property alias valueAxisYSensor5: valueAxisYSensor5
    property alias lineSeriesSensor6: lineSeriesSensor6
    property alias chartViewSensor6: chartViewSensor6
    property alias valueAxisXSensor6: valueAxisXSensor6
    property alias valueAxisYSensor6: valueAxisYSensor6
    property alias lineSeriesSensor7: lineSeriesSensor7
    property alias chartViewSensor7: chartViewSensor7
    property alias valueAxisXSensor7: valueAxisXSensor7
    property alias valueAxisYSensor7: valueAxisYSensor7
    property alias lineSeriesSensor8: lineSeriesSensor8
    property alias chartViewSensor8: chartViewSensor8
    property alias valueAxisXSensor8: valueAxisXSensor8
    property alias valueAxisYSensor8: valueAxisYSensor8

    property alias mouseAreaSensorView1: mouseAreaSensorView1
    property alias mouseAreaSensorView2: mouseAreaSensorView2
    property alias mouseAreaSensorView3: mouseAreaSensorView3
    property alias mouseAreaSensorView4: mouseAreaSensorView4
    property alias mouseAreaSensorView5: mouseAreaSensorView5
    property alias mouseAreaSensorView6: mouseAreaSensorView6
    property alias mouseAreaSensorView7: mouseAreaSensorView7
    property alias mouseAreaSensorView8: mouseAreaSensorView8
    property alias mouseAreaSensorMenuOption: mouseAreaSensorMenuOption
    property alias  busyIndicatorChartViewSensor1: busyIndicatorChartViewSensor1
    property alias  busyIndicatorChartViewSensor2: busyIndicatorChartViewSensor2
    property alias  busyIndicatorChartViewSensor3: busyIndicatorChartViewSensor3
    property alias  busyIndicatorChartViewSensor4: busyIndicatorChartViewSensor4
    property alias  busyIndicatorChartViewSensor5: busyIndicatorChartViewSensor5
    property alias  busyIndicatorChartViewSensor6: busyIndicatorChartViewSensor6
    property alias  busyIndicatorChartViewSensor7: busyIndicatorChartViewSensor7
    property alias  busyIndicatorChartViewSensor8: busyIndicatorChartViewSensor8

    property alias textNodeChannel: textNodeChannel

    Settings{
        property alias textNodeChannel: textNodeChannel.text
    }

    Rectangle {
        id: paneBackground
        anchors.fill: parent
        color: "#eeeeeeee"
    }

    Flickable {
        id: flickableSensor
        height: 1200
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
        //contentHeight: appWindow.height * 0.75
        contentHeight: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor1.height * 4 : chartViewSensor1.height * 8)

        ChartView {
            id: chartViewSensor1
            title: "ความชื้นในดิน #1"
            titleFont: fontRegular.name
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor1
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor1
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor1
                axisY: valueAxisYSensor1
                axisX: valueAxisXSensor1
            }
            MouseArea{
                id: mouseAreaSensorView1
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor1
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }
        ChartView {
            id: chartViewSensor2
            title: "ความชื้นในดิน #2"
            titleFont: fontRegular.name
            anchors.left: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor1.right : parent.left)
            anchors.leftMargin: 0
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.top : chartViewSensor1.bottom)
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor2
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor2
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor2
                axisY: valueAxisYSensor2
                axisX: valueAxisXSensor2
            }

            MouseArea{
                id: mouseAreaSensorView2
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor2
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }

        ChartView {
            id: chartViewSensor3
            title: "ความชื้นในดิน #2"
            titleFont: fontRegular.name
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor1.bottom : chartViewSensor2.bottom)
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor3
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor3
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor3
                axisY: valueAxisYSensor3
                axisX: valueAxisXSensor3
            }

            MouseArea{
                id: mouseAreaSensorView3
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor3
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }
        ChartView {
            id: chartViewSensor4
            title: "ความชื้นในดิน #2"
            titleFont: fontRegular.name
            anchors.left: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor3.right : parent.left)
            anchors.leftMargin: 0
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor2.bottom : chartViewSensor3.bottom)
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor4
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor4
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor4
                axisY: valueAxisYSensor4
                axisX: valueAxisXSensor4
            }

            MouseArea{
                id: mouseAreaSensorView4
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor4
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }

        ChartView {
            id: chartViewSensor5
            title: "ความชื้นในดิน #2"
            titleFont: fontRegular.name
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor3.bottom : chartViewSensor4.bottom)
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor5
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor5
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor5
                axisY: valueAxisYSensor5
                axisX: valueAxisXSensor5
            }

            MouseArea{
                id: mouseAreaSensorView5
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor5
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }
        ChartView {
            id: chartViewSensor6
            title: "ความชื้นในดิน #2"
            titleFont: fontRegular.name
            anchors.left: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor5.right : parent.left)
            anchors.leftMargin: 0
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor4.bottom : chartViewSensor5.bottom)
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor6
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor6
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor6
                axisY: valueAxisYSensor6
                axisX: valueAxisXSensor6
            }

            MouseArea{
                id: mouseAreaSensorView6
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor6
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }
        ChartView {
            id: chartViewSensor7
            title: "ความชื้นในดิน #2"
            titleFont: fontRegular.name
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor5.bottom : chartViewSensor6.bottom)
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor7
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor7
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor7
                axisY: valueAxisYSensor7
                axisX: valueAxisXSensor7
            }

            MouseArea{
                id: mouseAreaSensorView7
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor7
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }
        ChartView {
            id: chartViewSensor8
            title: "ความชื้นในดิน #2"
            titleFont: fontRegular.name
            anchors.left: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor7.right : parent.left)
            anchors.leftMargin: 0
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewSensor6.bottom : chartViewSensor7.bottom)
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.85 - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width - 10)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisYSensor8
                min: 0
                max: 20
                titleText: ""
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            DateTimeAxis{
                id: valueAxisXSensor8
 /*               min: 0
                max: farmData.week*/
                format: "HH:mm - d MMM"
                titleText: "วันที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesSensor8
                axisY: valueAxisYSensor8
                axisX: valueAxisXSensor8
            }

            MouseArea{
                id: mouseAreaSensorView8
                anchors.fill: parent
            }

            BusyIndicator {
                id: busyIndicatorChartViewSensor8
                width: parent.height/8
                height: parent.height/8
                anchors.centerIn: parent
                running: false
                //visible: false
            }
        }
    }

    DropShadow {
        anchors.fill: rectangleSensorHeader
        horizontalOffset: 0
        verticalOffset: 1
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: rectangleSensorHeader
    }

    Rectangle {
        id: rectangleSensorHeader
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
        }

            Text {
                id: textSensorHeader
                color: "#ffffff"
                text: "ข้อมูลเครือข่ายเซ็นเซอร์ไร้สาย : " + textNodeChannel.text
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.height * 0.4 : parent.height * 0.2)
                font.bold: true
                font.family: fontRegular.name
            }
            Text{
                id: textNodeChannel
                color: "#ffffff"
                text: "141904"
                anchors.left: textSensorHeader.right
                anchors.leftMargin: 5
                anchors.verticalCenter: textSensorHeader.verticalCenter
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.height * 0.4 : parent.height * 0.2)
                font.bold: true
                font.family: fontRegular.name
                visible: false
            }

        Image {
            id: imageSensorMenu
            width: 30
            height: 30
            anchors.verticalCenter: textSensorHeader.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 16
            source: Material.theme ? "images/ic_more_vert_black_18dp.png" : "images/ic_more_vert_white_18dp.png"

            MouseArea {
                id: mouseAreaSensorMenuOption
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.fill: parent
            }
        }
    }
}
