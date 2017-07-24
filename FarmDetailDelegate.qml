import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: itemDelegateDetail
    property alias labelCaption: labelCaption.text
    property alias labelValue: labelValue.text
    property alias labelUnit: labelUnit.text
    property alias labelSubCaption: labelSubCaption.text
    height: 50
    anchors.rightMargin: 5
    anchors.leftMargin: 5
    anchors.bottomMargin: 5
    anchors.topMargin: 5
    anchors.fill: parent

    Label {
        id: labelCaption
        y: 9
        text: modelData
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: 12
    }

    Label {
        id: labelValue
        y: 9
        text: modelData
        anchors.left: labelUnit.left
        anchors.leftMargin: -180
        font.pixelSize: 12
    }

    Label {
        id: labelUnit
        y: 9
        text: modelData
        anchors.left: parent.right
        anchors.leftMargin: -90
        font.pixelSize: 12
    }

    Label {
        id: labelSubCaption
        text: modelData
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: labelCaption.bottom
        anchors.topMargin: 5
        font.italic: true
        font.pixelSize: 12
    }
}
