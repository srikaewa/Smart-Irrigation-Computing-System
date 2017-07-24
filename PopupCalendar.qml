import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

Item {
    id: itemPopupCalendar
    width: 360
    height: 360

    Popup {
        id: aboutDialog
        modal: true
        focus: true
        leftMargin: 0
        rightMargin: 0
        topMargin: 0
        bottomMargin: 0

        Label{
            text: calendar.selectedDate
        }

        Calendar {
            id: calendar
            weekNumbersVisible: true
            navigationBarVisible: true
            frameVisible: true
            style: CalendarStyle{
                //Material.theme: Material.Light
                //Material.accent: Material.Orange
            }
        }
    }
}
