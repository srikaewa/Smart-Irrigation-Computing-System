import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

StackView {
    id: itemAboutUs
    width: 480
    height: 1800

    Rectangle {
        anchors.fill: parent
        color: "#eeeeeeee"
    }

    //property alias mouseAreaAboutUsMenu: mouseAreaAboutUsMenu
    Flickable {
        //height: availableHeight
        boundsBehavior: Flickable.DragAndOvershootBounds
        clip: true
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.top: rectangleAboutUsHeader.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        contentWidth: parent.width
        contentHeight: 2100

        ColumnLayout {
            id: columnLayout
            //anchors.bottomMargin: 81
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.fill: parent
            spacing: 20
            Label {
                text: ""
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.04 : availableHeight * 0.02)
                font.family: fontRegular.name
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                id: labelProjectTitle
                //height: 50
                text: qsTr("การพัฒนาซอฟต์แวร์ระบบประมวลผลการให้น้ำไร่มันสำปะหลัง")
                Layout.alignment: Qt.AlignCenter
                font.bold: true
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.04 : availableHeight * 0.02)
                font.family: fontRegular.name
            }

            Label {
                id: labelProjectTitle2
                text: qsTr("ด้วยแบบจำลองระบบการชลประทาน")
                Layout.alignment: Qt.AlignCenter
                font.bold: true
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.04 : availableHeight * 0.02)
                font.family: fontRegular.name
            }

            Label {
                id: labeSupportedBy
                text: qsTr("สนับสนุนการวิจัย พัฒนาและนวัตกรรมโดย")
                font.bold: true
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.03 : availableHeight * 0.015)
                font.family: fontRegular.name
                Layout.alignment: Qt.AlignCenter
            }

            Image {
                id: imageNRCTLogo
                //width: 177
                //height: 58
                Layout.preferredHeight: 220
                Layout.alignment: Qt.AlignCenter
                fillMode: Image.PreserveAspectFit
                source: "images/NRCT2.png"
            }
            Image {
                id: imageNSTDALogo
                //width: 177
                //height: 58
                Layout.preferredHeight: 80
                Layout.alignment: Qt.AlignCenter
                fillMode: Image.PreserveAspectFit
                source: "images/nstda.png"
            }

            Label {
                text: ""
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.03 : availableHeight * 0.015)
                font.family: fontRegular.name
            }

            Label {
                id: labelResearchStaffs
                text: qsTr("คณะวิจัย")
                font.bold: true
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.03 : availableHeight * 0.015)
                font.family: fontRegular.name
                Layout.alignment: Qt.AlignCenter
            }

            Image {
                id: imageSUTLogo
                //width: 153
                //height: 178
                Layout.preferredHeight: 200
                fillMode: Image.PreserveAspectFit
                Layout.alignment: Qt.AlignCenter
                source: "images/sut_logo_stroke.png"
            }

            Label {
                id: labelResearcher
                text: qsTr("รองศาสตราจารย์ ดร.อาทิตย์ ศรีแก้ว\nผู้ช่วยศาสตราจารย์ ดร.สุดชล วุ้นประเสริฐ\nผู้ช่วยศาสตราจารย์ ดร.ประโยชน์ คำสวัสดิ์\nผู้ช่วยศาสตราจารย์ ดร.ฐิติพร มะชิโกวา")
                Layout.alignment: Qt.AlignCenter
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.03 : availableHeight * 0.015)
                font.family: fontRegular.name
            }

            Label {
                id: labelResearchAssistance
                text: qsTr("คณะผู้ช่วยวิจัย")
                font.bold: true
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.03 : availableHeight * 0.015)
                font.family: fontRegular.name
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignCenter
            }

            Label {
                id: labelResearchAssistanceName
                text: qsTr("ระติ พลทามูล")
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? availableHeight
                                                              * 0.03 : availableHeight * 0.015)
                font.family: fontRegular.name
                Layout.alignment: Qt.AlignCenter
            }

            Image {
                id: imageResearchGroup
                //width: 281
                //height: 161
                Layout.preferredWidth: availableWidth * 0.85
                fillMode: Image.PreserveAspectFit
                Layout.alignment: Qt.AlignCenter
                source: "images/ResearchGroup2.jpg"
            }
        }
    }

    DropShadow {
        anchors.fill: rectangleAboutUsHeader
        horizontalOffset: 0
        verticalOffset: 1
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: rectangleAboutUsHeader
    }

    Rectangle {
        id: rectangleAboutUsHeader
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
            Label {
                id: labelFarmDetailHeader
                x: 133
                y: 0
                color: "#ffffff"
                text: "เกี่ยวกับเรา"
                fontSizeMode: Text.HorizontalFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: fontRegular.name
                font.pixelSize: (Screen.primaryOrientation
                                 == Qt.LandscapeOrientation ? parent.height
                                                              * 0.4 : parent.height * 0.2)
            }
            source: "images/CassavaHeader.png"
        }
    }
}
