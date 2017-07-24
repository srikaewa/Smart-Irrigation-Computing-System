import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: itemExpandableDetail
    width: 460
    height: 300
    property alias paneDetail: paneDetail
    property alias labelDripPerTape: labelDripPerTape
    property alias labelDripTotal: labelDripTotal
    property alias labelFlowRateTotal: labelFlowRateTotal
    property alias labelWaterInGroundPerHour: labelWaterInGroundPerHour
    property alias labelHeader: labelHeader
    property string labelHeaderText

    Pane {
        id: paneDetail
        visible: true
        spacing: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.top: labelHeader.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.topMargin: 0

        Label {
            id: labelDripPerTapeCaption
            y: 0
            text: qsTr("จำนวนหัวน้ำหยดต่อเทป 1 เส้น")
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 14
        }

        Label {
            id: labelDripPerTape
            x: 320
            y: 3
            text: qsTr("260")
            font.pixelSize: 14
            font.bold: true
            anchors.right: labelDripPerTapeUnit.left
            anchors.rightMargin: 6
        }

        Label {
            id: labelDripPerTapeUnit
            y: 0
            text: qsTr("หัว")
            font.pixelSize: 14
            anchors.left: parent.right
            anchors.leftMargin: -85
            horizontalAlignment: Text.AlignLeft
        }

        Label {
            id: labelDripPerTapeDetail
            text: qsTr("ความยาวเทปน้ำหยด/ระยะห่างระหว่างหัวน้ำหยด")
            font.pixelSize: 12
            anchors.top: labelDripPerTapeCaption.bottom
            anchors.topMargin: 2
            anchors.left: parent.left
            anchors.leftMargin: 0
        }

        Label {
            id: labelDripTotalCaption
            y: 60
            text: qsTr("จำนวนหัวน้ำหยดทั้งหมด")
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 14
        }

        Label {
            id: labelDripTotal
            x: 296
            y: 65
            text: qsTr("2080")
            font.pixelSize: 14
            anchors.right: labelDripTotalUnit.left
            anchors.rightMargin: 6
            font.bold: true
        }

        Label {
            id: labelDripTotalUnit
            y: 62
            text: qsTr("หัว/พท.")
            font.pixelSize: 14
            anchors.left: parent.right
            anchors.leftMargin: -85
        }

        Label {
            id: labelDripTotalDetail
            x: 0
            text: qsTr("จำนวนเทปทั้งหมด x จำนวนหัวน้ำหยดต่อเทป")
            font.pixelSize: 12
            anchors.top: labelDripTotalCaption.bottom
            anchors.topMargin: 2
        }

        Label {
            id: labelFlowRateTotalCaption
            y: 121
            text: qsTr("อัตราการไหลของน้ำเข้าพื้นที่")
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 14
        }

        Label {
            id: labelFlowRateTotalUnit
            y: 126
            text: qsTr("ลิตร/ชม./พท.")
            font.pixelSize: 14
            anchors.left: parent.right
            anchors.leftMargin: -85
        }

        Label {
            id: labelFlowRateTotal
            x: 308
            y: 130
            text: qsTr("5200")
            anchors.right: labelFlowRateTotalUnit.left
            anchors.rightMargin: 6
            font.pixelSize: 14
            font.bold: true
        }

        Label {
            id: labelFlowRateTotalDetail
            x: 0
            text: qsTr("อัตราการไหลต่อหัวน้ำหยด x จำนวนหัวหยดทั้งหมด")
            font.pixelSize: 12
            anchors.top: labelFlowRateTotalCaption.bottom
            anchors.topMargin: 2
        }

        Label {
            id: labelWaterInGroundPerHourCaption
            y: 180
            text: qsTr("ความสูงของน้ำในดินต่อ 1 ชม.")
            font.pixelSize: 14
            anchors.left: parent.left
            anchors.leftMargin: 0
        }

        Label {
            id: labelWaterInGroundPerHourUnit
            y: 180
            text: qsTr("มิลลิเมตร/ชม.")
            font.pixelSize: 14
            anchors.left: parent.right
            anchors.leftMargin: -81
        }

        Label {
            id: labelWaterInGroundPerHour
            x: 302
            y: 184
            text: qsTr("7.9365")
            font.pixelSize: 14
            anchors.right: labelWaterInGroundPerHourUnit.left
            anchors.rightMargin: 6
            font.bold: true
        }

        Label {
            id: labelWaterInGroundPerHourDetail
            x: 0
            text: qsTr("อัตราการไหลของน้ำเข้าต่อพื้นที่")
            anchors.top: labelWaterInGroundPerHourCaption.bottom
            anchors.topMargin: 2
            font.pixelSize: 12
        }
    }
    Label {
        id: labelHeader
        height: 30
        text: paneDetail.visible ? "Less Details..." : "More Details..."
        font.bold: false
        font.pixelSize: 14
        anchors.top: parent.top
        anchors.topMargin: 0
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        MouseArea {
            id: mouseAreaHeader
            anchors.fill: parent
            anchors.top: parent.top
            anchors.left: parent.left
            onClicked: paneDetail.visible = !paneDetail.visible
        }
    }

}
