import QtQuick 2.4

PushStartDateForm {
    Component.onCompleted: {
        labelStartDate.text = Qt.formatDate(calendarStartDate.selectedDate,"ddd, MMM dd, yyyy")
        labelStopDate.text = Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy")
        //swipeView.enabled = false

    }

    calendarStartDate.onSelectedDateChanged: {
        farmData.startDate = calendarStartDate.selectedDate
        labelStartDate.text = Qt.formatDate(farmData.startDate,"ddd, MMM dd, yyyy");
        labelStopDate.text = Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy");
        //console.debug("Start date changed...!");
        pageToday.updateTodayWateringList();
    }

    mouseAreaStartDateBack.onClicked: {
        stackViewFarmDetails.labelStartDate.text = Qt.formatDate(farmData.startDate,"ddd, MMM dd, yyyy");
        stackViewFarmDetails.labelStopDate.text = Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy");
        tabBar.visible = true;
        stackViewFarmDetails.pop();
    }
}
