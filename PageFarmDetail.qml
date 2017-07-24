import QtQuick 2.4
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4



PageFarmDetailForm {
    Component.onCompleted: {
        var farmStr = farmData.getFarmTitleList();
        var i;
        listFarmTitle.clear();
        for(i=0;i<farmData.getFarmCount();i++)
        {
            console.log("Get farm list [" + i +"] -> "+farmStr[i]);
            listFarmTitle.append({title: ""+farmStr[i]});
        }
        //comboBoxFarmTitle.displayText = farmData.farmTitle;
    }

    comboBoxFarmTitle.onCurrentIndexChanged: {
        farmData.farmTitle = comboBoxFarmTitle.currentText;
    }

    spinBoxTapeLength.onValueChanged: {
        farmData.tapeLength = spinBoxTapeLength.value;
        expandableFarmDetailPane.labelDripPerTape.text = farmData.dripPerTape.toString();
        expandableFarmDetailPane.labelDripTotal.text = farmData.dripTotal.toString();
        expandableFarmDetailPane.labelFlowRateTotal.text = farmData.flowRateTotal.toString();
        expandableFarmDetailPane.labelWaterInGroundPerHour.text = Math.round(farmData.waterInGroundPerHour*10000)/10000;
        pageToday.updateTodayWateringList();
    }

    spinBoxDripInterval.onValueChanged: {
        farmData.dripInterval = spinBoxDripInterval.value/10;
        expandableFarmDetailPane.labelDripPerTape.text = farmData.dripPerTape.toString();
        expandableFarmDetailPane.labelDripTotal.text = farmData.dripTotal.toString();
        expandableFarmDetailPane.labelFlowRateTotal.text = farmData.flowRateTotal.toString();
        expandableFarmDetailPane.labelWaterInGroundPerHour.text = Math.round(farmData.waterInGroundPerHour*10000)/10000;
        pageToday.updateTodayWateringList();
    }

    spinBoxTapeNumber.onValueChanged: {
        farmData.tapeNumber = spinBoxTapeNumber.value;
        expandableFarmDetailPane.labelDripPerTape.text = farmData.dripPerTape.toString();
        expandableFarmDetailPane.labelDripTotal.text = farmData.dripTotal.toString();
        expandableFarmDetailPane.labelFlowRateTotal.text = farmData.flowRateTotal.toString();
        expandableFarmDetailPane.labelWaterInGroundPerHour.text = Math.round(farmData.waterInGroundPerHour*10000)/10000;
        pageToday.updateTodayWateringList();
    }

    spinBoxDripRate.onValueChanged: {
        farmData.dripRate = spinBoxDripRate.value/10;
        expandableFarmDetailPane.labelDripPerTape.text = farmData.dripPerTape.toString();
        expandableFarmDetailPane.labelDripTotal.text = farmData.dripTotal.toString();
        expandableFarmDetailPane.labelFlowRateTotal.text = farmData.flowRateTotal.toString();
        expandableFarmDetailPane.labelWaterInGroundPerHour.text = Math.round(farmData.waterInGroundPerHour*10000)/10000;
        pageToday.updateTodayWateringList();
    }

    spinBoxTapeInterval.onValueChanged: {
        farmData.tapeInterval = spinBoxTapeInterval.value/10;
        expandableFarmDetailPane.labelDripPerTape.text = farmData.dripPerTape.toString();
        expandableFarmDetailPane.labelDripTotal.text = farmData.dripTotal.toString();
        expandableFarmDetailPane.labelFlowRateTotal.text = farmData.flowRateTotal.toString();
        expandableFarmDetailPane.labelWaterInGroundPerHour.text = Math.round(farmData.waterInGroundPerHour*10000)/10000;
        pageToday.updateTodayWateringList();
    }

    comboBoxSoilType.onCurrentIndexChanged: {
        farmData.soilId = comboBoxSoilType.currentIndex+1;
        labelHoldingCapacity.text = "ดินอุ้มน้ำได้ "  + Math.round(farmData.holdingCapacity*1000)/1000 + " มม./ชม.";
        labelAllowableWaterDepletion.text = "ยอมให้น้ำแก่พืชได้ " + farmData.allowableWaterDepletion + "%";
        pageToday.updateTodayWateringList();
    }

    /*expandableCalendarStartDate.on: {
        farmData.startDate = expandableCalendarStartDate.calendarSelectedDate
        labelStopDate.text = Qt.formatDate(farmData.stopDate,"ddd, MM dd, yyyy");
        console.debug("Start date changed...!");
    }*/
    calendarStartDate.onSelectedDateChanged: {
        farmData.startDate = calendarStartDate.selectedDate
        labelStopDate.text = Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy");
        //console.debug("Start date changed...!");
        pageToday.updateTodayWateringList();
    }
}
