import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

Item {
    id: itemExpandableCalendar
    width: 300
    height: 300
    property alias calendarSelectedDate: calendar.selectedDate
    property alias labelSelectedDate: labelSelectedDate
    property alias labelSelectedDateCaption: labelSelectedDateCaption

    Pane {
        id: paneMain
        y: 0
        height: 42
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Label {
            id: labelSelectedDate
            x: 109
            y: 14
            //text: calendar.selectedDate
            text: Qt.formatDate(calendar.selectedDate,"ddd, dd MMM yyyy")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            font.bold: true
            font.pixelSize: 14
        }

        MouseArea{
            anchors.fill: parent
            onClicked: popupDialog.open()
        }
        Popup {
            id: popupDialog
            modal: true
            focus: true
          //  topMargin: paneMain.bottom
            Label{
                id: labelSelectedDateCaption
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
                font.pixelSize: 14
                width: parent.width
            }

            Calendar {
                id: calendar
                weekNumbersVisible: true
                navigationBarVisible: true
                frameVisible: true
                //style: CalendarStyle{
                    //Material.theme: Material.Light
                    //Material.accent: Material.Orange
                //}
                onSelectedDateChanged: {
                    popupDialog.close()
                    labelSelectedDate.text = calendar.selectedDate
                }
            }
         }
    }

}
