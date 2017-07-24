import QtQuick 2.4

PushPumpInfoForm {
    Component.onCompleted: {
        tabBar.visible = false;
    }

    mouseAreaPumpInfoBack.onClicked: {
        stackViewToday.pop();
        tabBar.visible = true;
    }
}
