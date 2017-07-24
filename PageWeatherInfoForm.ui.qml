import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0
import QtPositioning 5.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtLocation 5.3
import QtCharts 2.0
import QtGraphicalEffects 1.0


/**** mapbox token ****/
// PrecisionIrrigationSystem
// sk.eyJ1Ijoic3Jpa2Fld2EiLCJhIjoiY2lzbXNud3AzMDAwZjJ5bGZoaHl2OThobCJ9.kDhA0M_Ud-528tLO5gXvnw
StackView {
    id: itemWeatherInfo
    width: 480
    height: 1600
    //property alias labelPullDown: labelPullDown
    //property alias buttonGetETp: buttonGetETp
    property alias mouseAreaMap: mouseAreaMap
    property alias labelLongitude: labelLongitude
    property alias hereMap: hereMap
    property alias marker: marker
    property alias labelLatitude: labelLatitude
    property alias gpsPosition: gpsPosition
    //property alias mouseAreaWeatherInfoMenu: mouseAreaWeatherInfoMenu
    property alias chartViewETp: chartViewETp
    property alias lineSeriesETp: lineSeriesETp
    property alias busyIndicatorChartViewETp: busyIndicatorChartViewETp

    property alias flickableLocation: flickableLocation

    Rectangle {
        id: paneBackground
        anchors.fill: parent
        color: "#eeeeeeee"
    }

    Plugin {
        id: mapPlugin
        name: "here"
        PluginParameter {
            name: "here.app_id"
            value: "CD5ZNcUPxSCd4eu9Ipt5"
        }
        PluginParameter {
            name: "here.token"
            value: "80gzJuzovEcRTBGgxXXSKw"
        }
    }

    //Flickable {
    Rectangle{
        id: flickableLocation
        //boundsBehavior: Flickable.DragAndOvershootBounds
        //clip: true
        color: Qt.rgba(0,0,0,0)
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.top: rectangleWeatherInfoHeader.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        //contentWidth: parent.width
        //contentHeight: (Screen.primaryOrientation == Qt.Landscape ? appWindow.height : 1600 )

        PositionSource {
            id: gpsPosition
            //preferredPositioningMethods: PositionSource.SatellitePositioningMethods
            preferredPositioningMethods: PositionSource.AllPositioningMethods
            active: true
            updateInterval: 1000 // ms
            onPositionChanged: active = false
        }

        DropShadow {
            anchors.fill: rectangleMapBody
            horizontalOffset: 1
            verticalOffset: 1
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: rectangleMapBody
        }

        Rectangle {
            id: rectangleMapBody
            anchors.top: parent.top
            anchors.topMargin: 16
            anchors.left: parent.left
            anchors.leftMargin: 16
            width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width/2 - 16 : parent.width - 32)
            height: (Screen.primaryOrientation == Qt.LandscapeOrientation? appWindow.height * 0.8 - 48 - tabBar.height : appWindow.width-32)
            color: "#ffffff"

            Map {
                id: hereMap
                property MapCircle circle

                anchors.fill: parent

                copyrightsVisible: false

                plugin: mapPlugin

                center: QtPositioning.coordinate(farmData.latitude,farmData.longitude)
                    //                latitude: 14.949298
                    //                longitude: 102.049343
                    //latitude: gpsPosition.position.coordinate.latitude
                    //longitude: gpsPosition.position.coordinate.longitude
                    //latitude: farmData.latitude
                    //longitude: farmData.longitude



                zoomLevel: (hereMap.maximumZoomLevel + hereMap.minimumZoomLevel) / 2

                gesture.enabled: true
                gesture.acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture

                MapQuickItem {
                    id: markerCurrentPosition
                    anchorPoint.x: imageCurrentMarker.width / 2
                    anchorPoint.y: imageCurrentMarker.height / 2

                    sourceItem: Image {
                        id: imageCurrentMarker
                        x: 210
                        y: 153
                        source: "images/currentPositionMarker.png"
                    }

                    coordinate {
                        latitude: gpsPosition.position.coordinate.latitude
                        longitude: gpsPosition.position.coordinate.longitude
                    }
                }

                MapQuickItem {
                    id: marker
                    anchorPoint.x: imageMarker.width / 2
                    anchorPoint.y: imageMarker.height

                    sourceItem: Image {
                        id: imageMarker
                        x: 210
                        y: 127
                        source: "images/map-marker-icon_small.png"
                    }

                    coordinate: hereMap.center
                }

                MouseArea {
                    id: mouseAreaMap
                    anchors.fill: parent
                }

                Rectangle{
                    id: rectangleLatLongLabel
//                    objectName: "rectangleLatLongLabelObject"
                    color: "#88ffffff"
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    width: parent.width - 20
                    height: labelLatitude.font.pixelSize * 4
                    Label {
                        id: labelLatitudeCaption
                        text: qsTr("Latitude")
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.022 : availableHeight * 0.012)
                        font.family: fontRegular.name
                    }
                    Label {
                        id: labelLatitude
                        text: farmData.latitude
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: labelLatitudeCaption.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.022 : availableHeight * 0.012)
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Label {
                        id: labelLongitudeCaption
                        text: qsTr("Longitude")
                        anchors.top: labelLatitudeCaption.bottom
                        anchors.topMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.022 : availableHeight * 0.012)
                        font.family: fontRegular.name
                    }

                    Label {
                        id: labelLongitude
                        text: farmData.longitude
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: labelLongitudeCaption.verticalCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? availableHeight * 0.022 : availableHeight * 0.012)
                    }
                }
            }

        }
        ComboBox {
            id: comboBoxSelectMapType
            x: 10
            height: 40
            anchors.top: rectangleMapBody.bottom
            anchors.topMargin: 10
            anchors.right: rectangleMapBody.right
            anchors.rightMargin: 0
            anchors.left: rectangleMapBody.left
            anchors.leftMargin: 0
            model: hereMap.supportedMapTypes
            textRole: "description"
            onCurrentIndexChanged: hereMap.activeMapType = hereMap.supportedMapTypes[currentIndex]
            font.family: fontRegular.name
        }

        ChartView {
             id: chartViewETp
             title: "ค่าสภาพอากาศ ETp"
             titleFont: fontRegular.name
             anchors.right: parent.right
             anchors.rightMargin: 0
             //anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.top : labelLatitudeCaption.bottom)
             anchors.top: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.top : comboBoxSelectMapType.bottom)
             anchors.topMargin: 0
             width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.width/2: parent.width)
             //height: availableHeight * 0.85 - tabBar.height
             height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? (appWindow.height*0.85 - 16) : parent.width * 0.80)
             antialiasing: true
             //theme: ChartView.ChartThemeDark

             backgroundColor: "#00ffffff"
             legend.visible: false
             //titleColor: Material.theme ? "#FFFFFF" : "#000000"
             ValueAxis {
                 id: valueAxisY
                 min: 0.0
                 max: 6.0
                 titleText: "ETp"
                 titleFont: fontRegular.name
                 labelsFont: Qt.font({pixelSize: 12})
             }
             ValueAxis {
                 id: valueAxisX
                 min: 0
                 max: 366
                 titleText: "วันที่"
                 titleFont: fontRegular.name
                 labelsFont: Qt.font({pixelSize: 12})
             }
             LineSeries {
                 id: lineSeriesETp
                 axisY: valueAxisY
                 axisX: valueAxisX
             }
             BusyIndicator {
                 id: busyIndicatorChartViewETp
                 width: parent.height/8
                 height: parent.height/8
                 anchors.centerIn: parent
                 running: false
                 //visible: false
             }
         }
        //flickable end
    }

    DropShadow {
        anchors.fill: rectangleWeatherInfoHeader
        horizontalOffset: 0
        verticalOffset: 1
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: rectangleWeatherInfoHeader
    }

    Rectangle {
        id: rectangleWeatherInfoHeader
        y: 0
        height: availableHeight * 0.15
        //color: "#ffcc80"
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

            Label {
                id: labelWeatherInfoHeader
                color: "#ffffffff"
                text: qsTr("ตำแหน่งแปลงเกษตร")
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? parent.height * 0.4 : parent.height * 0.2)
                font.family: fontRegular.name
            }

            /*Text {
                                                    id: textWeatherInfoHeader
                                                                                                                                        x: 146
                                                                                                                                                                                                                                                                                        y: -1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    color: "#000000"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            text: qsTr("ตำแหน่งแปลงเกษตร")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                anchors.horizontalCenter: parent.horizontalCenter
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                anchors.verticalCenterOffset: 0
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            font.bold: true
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    anchors.verticalCenter: parent.verticalCenter
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        font.pixelSize: 18
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        font.family: fontRegular.name
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                }*/
        }
    }
}
