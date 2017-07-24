import QtQuick 2.7
import QtQuick.Controls 2.0
import QtCharts 2.0
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

StackView {
    id: itemPagePlantDetail
    width: 480
    height: 720

    property alias labelPlantDetailHeader: labelPlantDetailHeader
    property alias comboBoxPlantType: comboBoxPlantType
    property alias chartViewKc: chartViewKc
    property alias lineSeriesKc: lineSeriesKc
    property alias chartViewRootDepth: chartViewRootDepth
    property alias lineSeriesRootDepth: lineSeriesRootDepth

    Rectangle {
        id: paneBackground
        anchors.fill: parent
        color: "#eeeeeeee"
    }

    Flickable {
        id: flickablePlantDetail
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
        contentHeight: appWindow.height * 0.8

        ComboBox {
            id: comboBoxPlantType
            height: 40
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            font.pixelSize: 17
            font.family: fontRegular.name
            model: ["มันสำปะหลัง", "อ้อย"]
            currentIndex: farmData.plantId - 1
            //Material.theme: Material.Dark
        }

        ChartView {
            id: chartViewKc
            title: "ค่าสัมประสิทธิ์การใช้น้ำของพืช - Kc"
            titleFont: fontRegular.name
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: comboBoxPlantType.bottom
            anchors.topMargin: 0
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.75 - comboBoxPlantType.height - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width)
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark
            //titleColor: Material.theme ? "#FFFFFF" : "#000000"
            ValueAxis {
                id: valueAxisY
                min: 0
                max: 2
                titleText: "Kc"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            ValueAxis{
                id: valueAxisX
                min: 0
                max: farmData.week
                titleText: "สัปดาห์ที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesKc
                axisY: valueAxisY
                axisX: valueAxisX
            }
        }

        ChartView {
            id: chartViewRootDepth
            title: "ความยาวรากพืช - Root Depth (ซม.)"
            titleFont: fontRegular.name
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.75 - comboBoxPlantType.height - tabBar.height : availableHeight * 0.4)
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width / 2 - 10 : parent.width)
            anchors.left: (Screen.primaryOrientation == Qt.LandscapeOrientation ? chartViewKc.right : parent.left)
            anchors.leftMargin: 0
            //anchors.right: parent.right
            //anchors.rightMargin: 10
            anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? comboBoxPlantType.bottom : chartViewKc.bottom)
            anchors.topMargin: 0
            antialiasing: true
            backgroundColor: "#00FFFFFF"
            legend.visible: false
            //theme: ChartView.ChartThemeDark

            ValueAxis {
                id: valueAxisY2
                min: 0
                max: 40
                titleText: "Root Depth"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }
            ValueAxis{
                id: valueAxisX2
                min: 0
                max: farmData.week
                titleText: "สัปดาห์ที่"
                titleFont: fontRegular.name
                labelsFont: Qt.font({pixelSize: 12})
            }

            LineSeries{
                id: lineSeriesRootDepth
                axisY: valueAxisY2
                axisX: valueAxisX2
            }
        }
    }

    DropShadow {
        anchors.fill: rectanglePlantDetailHeader
        horizontalOffset: 0
        verticalOffset: 2
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: rectanglePlantDetailHeader
    }
    Rectangle {
        id: rectanglePlantDetailHeader
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
        }
        Label {
            id: labelPlantDetailHeader
            text: "รายละเอียดพืช - " + farmData.plantTitle + " (" + farmData.farmTitle + ")"
            color: "#ffffffff"
            font.bold: true
            font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.height * 0.4 : parent.height * 0.2)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontRegular.name
        }
    }
}
