import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
//import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

PageFarmDetailsForm {
    Component.onCompleted: {
        console.log("Farm ID -> "+farmData.farmId);
        updateComboBoxFarmList();
        // parameter update
        updateFarmParameterBox();
        // calculation update
        updateZoneCalculationBox();
    }

    function updateZoneCalculationBox()
    {
        labelZoneTitle.text =  "รายละเอียดพื้นที่โซน (" + farmData.zoneWidth.toFixed(1) + " เมตร x " + farmData.zoneLength.toFixed(1) + " เมตร) จากทั้งหมด "+farmData.getZoneTotal()+" โซน";
        labelTapeLength.text = farmData.tapeLength;
        labelDripPerTape.text = farmData.dripPerTape.toString();
        labelTapeNumber.text = farmData.tapeNumber.toString();
        labelDripTotal.text = farmData.dripTotal.toString();
        labelFlowRateTotal.text = farmData.flowRateTotal.toString();
        labelMaxFlowRate.text = farmData.getPEMaxFlowRate(farmData.PEDiameter);
        labelWaterInGroundPerHour.text = Math.round(farmData.waterInGroundPerHour*10000)/10000;
        labelFarmDetailHeader.text = farmData.farmTitle +" ("+farmData.plantTitle+")";
        pageToday.labelZoneCaption.text = "โซนการให้น้ำ (" + farmData.zoneWidth.toFixed(1) + " เมตร x " + farmData.zoneLength.toFixed(1) + " เมตร)";
        pageToday.updateTodayWateringList();
    }

    function updateFarmParameterBox()
    {
        pageToday.gridZoneRectangle.columns = 0;
        pageToday.gridZoneRectangle.rows = 0;
        labelAreaWidth.text = farmData.areaWidth;
        labelAreaLength.text = farmData.areaLength;
        labelDripInterval.text = farmData.dripInterval.toFixed(1);
        labelDripFlowRate.text = farmData.dripRate.toFixed(1);
        labelTapeInterval.text = farmData.tapeInterval.toFixed(1);
        labelPEDiameter.text = farmData.PEDiameter;
        labelSoilType.text = farmData.soilTitle;
        labelStartDate.text = Qt.formatDate(farmData.startDate,"ddd, MMM dd, yyyy");
        labelStopDate.text = Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy");
    }

    function updateComboBoxFarmList()
    {
        console.log("Update combobox FarmList from FarmDetails...");
        cbFarmItems.clear();
        var farmIdList = farmData.getFarmIdList();
        var farmTitleList = farmData.getFarmTitleList();
        //console.log("Farm Id -> " + farmIdList[0]);
        //console.log("Farm List -> " + farmTitleList[0]);
        var i;
        for(i=0;i< farmTitleList.length;i++)
        {
            cbFarmItems.append({farmId: farmIdList[i],farmTitle: farmTitleList[i]});
        }
        console.log("Farm ComboBox Text...");
        //var currentFarm = farmData.farmId;
        for(i=0;i< farmTitleList.length;i++)
        {
        // just display Farm title without doing anything else
            if(farmIdList[i] == farmData.farmId)
            {
                comboBoxSelectFarm.displayText = farmTitleList[i];
                pageToday.todayFarmTitle.text = farmTitleList[i];
            }
        }
        changeFarm = false;
    }

    function updatePlantDetailPage()
    {
        pagePlantDetail.comboBoxPlantType.currentIndex = farmData.plantId - 1;
        pagePlantDetail.labelPlantDetailHeader.text = "รายละเอียดพืช - " + farmData.plantTitle + " (" + farmData.farmTitle + ")";
    }

    function updateWeatherDetailPage()
    {
        pageWeatherInfo.labelLatitude.text = farmData.latitude;
        pageWeatherInfo.labelLongitude.text = farmData.longitude;
        pageWeatherInfo.updateETpGraph(farmData.latitude,farmData.longitude);
    }

    comboBoxSelectFarm.onCurrentIndexChanged: {
        busyIndicatorFarmDetail.running = true;
        var farmIdList = farmData.getFarmIdList();
        var farmTitleList = farmData.getFarmTitleList();
        //console.log("get farmId from comboBox -> " +
        //comboBoxSelectFarm.currentIndex + " " + cbFarmItems.get(comboBoxSelectFarm.currentIndex).farmId);
        //console.log("Combobox current text -> " + comboBoxSelectFarm.currentText);
        console.log("Combobox changeFarm = "+changeFarm);
        if(!changeFarm)
        {
                console.log("CurrentIndex get called...");
                console.log("cbFarmItems -> "+cbFarmItems.get(comboBoxSelectFarm.currentIndex));
                farmData.setCurrentFarm(cbFarmItems.get(comboBoxSelectFarm.currentIndex).farmId);                
                updateFarmParameterBox();
                updateZoneCalculationBox();
                updatePlantDetailPage();
                updateWeatherDetailPage();
                var i;
                var currentFarm = farmData.getCurrentFarm();
                for(i=0;i< farmTitleList.length;i++)
                {
                // just display Farm title without doing anything else
                    if(farmIdList[i] == currentFarm)
                    {
                        //comboBoxSelectFarm.displayText = farmTitleList[i];
                        //console.log("(PageFarmDetails) Combobox select -> " + farmTitleList[i]);
                        comboBoxSelectFarm.currentIndex = i;
                        comboBoxSelectFarm.displayText = farmTitleList[i];
                        pageToday.todayFarmTitle.text = farmTitleList[i];
                    }
                }                
        }
        busyIndicatorFarmDetail.running = false;
    }

    mouseAreaImageEditFarm.onClicked: {
        dialogEditFarmTitle.open();
    }

    mouseAreaImageAddFarm.onClicked: {
        dialogAddFarmTitle.open();
    }

    mouseAreaImageDeleteFarm.onClicked: {
        dialogDeleteFarmTitle.open();
    }

    mouseAreaAreaWidth.onClicked: {
        //tabBar.visible = false;
        //stackViewFarmDetails.push(Qt.resolvedUrl("PushTapeLength.qml"));
        dialogAreaWidth.spinBoxAreaWidth.value = farmData.areaWidth;
        dialogAreaWidth.open();
    }
    mouseAreaAreaLength.onClicked: {
        //tabBar.visible = false;
        //stackViewFarmDetails.push(Qt.resolvedUrl("PushTapeNumber.qml"));
        dialogAreaLength.spinBoxAreaLength.value = farmData.areaLength;
        dialogAreaLength.open();
    }
    mouseAreaDripInterval.onClicked: {
        //tabBar.visible = false;
        //stackViewFarmDetails.push(Qt.resolvedUrl("PushDripInterval.qml"));
        dialogDripInterval.spinBoxDripInterval.value = farmData.dripInterval*10;
        dialogDripInterval.open();
    }

    mouseAreaDripFlowRate.onClicked: {
        //tabBar.visible = false;
        //stackViewFarmDetails.push(Qt.resolvedUrl("PushDripFlowRate.qml"));
        dialogDripFlowRate.spinBoxDripFlowRate.value = farmData.dripRate*10;
        dialogDripFlowRate.open();
    }

    mouseAreaTapeInterval.onClicked: {
        //tabBar.visible = false;
        //stackViewFarmDetails.push(Qt.resolvedUrl("PushTapeInterval.qml"));
        dialogTapeInterval.spinBoxTapeInterval.value = farmData.tapeInterval*10;
        dialogTapeInterval.open();
    }

    mouseAreaPEDiameter.onClicked: {
        dialogPEDiameter.tumblerPEDiameter.currentIndex = farmData.getPEId(farmData.PEDiameter);
        dialogPEDiameter.labelFlowRateTotal.text = farmData.flowRateTotal;
        dialogPEDiameter.open();
    }

    mouseAreaSoilType.onClicked: {
        //tabBar.visible = false;
        //stackViewFarmDetails.push(Qt.resolvedUrl("PushSoilType.qml"));
        dialogSoilType.tumblerSoilType.currentIndex = farmData.soilId - 1;
        dialogSoilType.open();
    }

    mouseAreaStartDate.onClicked: {
        //tabBar.visible = false;
        //stackViewFarmDetails.push(Qt.resolvedUrl("PushStartDate.qml"));
        dialogStartDate.calendarStartDate.selectedDate = farmData.startDate;
        dialogStartDate.open();
    }

    Popup {
        id: dialogAddFarmTitle
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: appWindow.width *3/4
        contentHeight: 140

        Column {
            id: farmTitleAddColumn
            spacing: 20

            Label {
                text: "เพิ่มฟาร์ม/โซนใหม่"
                width: dialogAddFarmTitle.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            TextField {
                id: textAddFarmTitle
                width: dialogAddFarmTitle.availableWidth - 20
                text: "New Farm D - " + (comboBoxSelectFarm.count+1)
                font.family: fontRegular.name
                font.pixelSize: 17
                focus: true
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonAddFarmTitle
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.addNewFarm(textAddFarmTitle.text);
                        cbFarmItems.append({farmId: farmData.getCurrentFarm() , farmTitle: textAddFarmTitle.text});
                        comboBoxSelectFarm.displayText = "";
                        comboBoxSelectFarm.currentIndex = cbFarmItems.count;
                        pageToday.todayFarmTitle.text = cbFarmItems.get(cbFarmItems.count-1).farmTitle;
                        //pageToday.cbTodayFarmItems.append({farmId: cbFarmItems.count , farmTitle: textAddFarmTitle.text});
                        //farmData.setCurrentFarm(cbFarmItems.count);
                        //updateComboBoxFarmList();
                        //comboBoxSelectFarm.currentIndex = cbFarmItems.count;
                        labelFarmDetailHeader.text = farmData.farmTitle +" ("+farmData.plantTitle+")";
                        pagePlantDetail.labelPlantDetailHeader.text = "รายละเอียดพืช - " + farmData.plantTitle + " (" + farmData.farmTitle + ")";
                        dialogAddFarmTitle.close();
                    }

                }

                Button {
                    id: cancelButtonAddFarmTitle
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogAddFarmTitle.close();
                    }
                }
            }

        }
    }

    Popup {
        id: dialogEditFarmTitle
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: appWindow.width *3/4
        contentHeight: 140

        Column {
            id: farmTitleEditColumn
            spacing: 20

            Label {
                text: "แก้ไขชื่อฟาร์ม/โซน"
                width: dialogEditFarmTitle.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            TextField {
                id: textEditFarmTitle
                width: dialogEditFarmTitle.availableWidth
                anchors.horizontalCenter: parent.horizontalCenter
                text: comboBoxSelectFarm.displayText
                font.family: fontRegular.name
                font.pixelSize: 17
                focus: true
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButton
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.farmTitle = textEditFarmTitle.text
                        farmData.updateFarmTitle();
                        updateComboBoxFarmList();
                        comboBoxSelectFarm.displayText = textEditFarmTitle.text;
                        pageToday.todayFarmTitle.text = textEditFarmTitle.text
                        //tabBar.visible = true;
                        labelFarmDetailHeader.text = farmData.farmTitle +" ("+farmData.plantTitle+")";
                        pagePlantDetail.labelPlantDetailHeader.text = "รายละเอียดพืช - " + farmData.plantTitle + " (" + farmData.farmTitle + ")";

                        dialogEditFarmTitle.close();
                    }

                }

                Button {
                    id: cancelButton
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogEditFarmTitle.close();
                    }
                }
            }

        }
    }

    Popup {
        id: dialogDeleteFarmTitle
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: appWindow.width *3/4
        contentHeight: 100

        Column {
            id: farmTitleDeleteColumn
            spacing: 20

            Label {
                text: "ลบข้อมูลฟาร์ม/โซน '" + comboBoxSelectFarm.displayText + "' ???"
                width: dialogDeleteFarmTitle.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okDeleteButton
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.deleteFarm(farmData.getCurrentFarm());
                        updateComboBoxFarmList();
                        var farmTitleList = farmData.getFarmTitleList();
                        comboBoxSelectFarm.displayText = farmTitleList[0];
                        pageToday.todayFarmTitle.text = farmTitleList[0];
                        //tabBar.visible = true;
                        labelFarmDetailHeader.text = farmData.farmTitle +" ("+farmData.plantTitle+")";
                        pagePlantDetail.labelPlantDetailHeader.text = "รายละเอียดพืช - " + farmData.plantTitle + " (" + farmData.farmTitle + ")";
                        dialogDeleteFarmTitle.close();
                    }

                }

                Button {
                    id: cancelDeleteButton
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogDeleteFarmTitle.close();
                    }
                }
            }

        }
    }


    Popup {
        id: dialogAreaWidth
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: Math.min(appWindow.width, appWindow.height) / 4 * 3
        contentHeight: areaWidthColumn.height
        property alias spinBoxAreaWidth: spinBoxAreaWidth
        Column {
            id: areaWidthColumn
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: "ความกว้างของพื้นที่"
                width: dialogAreaWidth.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            SpinBox {
                id: spinBoxAreaWidth
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: fontRegular.name
                to: 1000
                from: 10
                value: farmData.areaWidth

                Label {
                    id: labelAreaWidthUnit
                    y: 6
                    text: qsTr("เมตร")
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }

            }
            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonAreaWidth
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.areaWidth = spinBoxAreaWidth.value;
                        labelAreaWidth.text = spinBoxAreaWidth.value;
                        updateZoneCalculationBox();
                        //tabBar.visible = true;
                        dialogAreaWidth.close();
                    }

                }

                Button {
                    id: cancelButtonAreaWidth
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogAreaWidth.close();
                    }
                }
            }

        }
    }

    Popup {
        id: dialogDripInterval
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: Math.min(appWindow.width, appWindow.height) / 4 * 3
        contentHeight: dripIntervalColumn.height
        property alias spinBoxDripInterval: spinBoxDripInterval

        Column {
            id: dripIntervalColumn
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: "ระยะห่างระหว่างหัวน้ำหยด"
                width: dialogDripInterval.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            SpinBox {
                id: spinBoxDripInterval
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: fontRegular.name
                from: 1
                value: farmData.dripInterval*to
                to: 1 * 10
                stepSize: 1
                property int decimals: 1;
                property real realValue: value / 100;

                validator: DoubleValidator {
                    bottom: Math.min(spinBoxDripInterval.from, spinBoxDripInterval.to)
                    top:  Math.max(spinBoxDripInterval.from, spinBoxDripInterval.to)
                }

                textFromValue: function(value, locale) {
                    return Number(value / 10).toLocaleString(locale, 'f', spinBoxDripInterval.decimals)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 10
                }


                Label {
                    id: labelDripIntervalUnit
                    y: 6
                    text: qsTr("เมตร")
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonDripInterval
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.dripInterval = spinBoxDripInterval.value/10;
                        labelDripInterval.text = (spinBoxDripInterval.value/10).toFixed(1);
                        updateZoneCalculationBox();
                        dialogDripInterval.close();
                    }

                }

                Button {
                    id: cancelButtonDripInterval
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogDripInterval.close();
                    }
                }
            }

        }
    }

    Popup {
        id: dialogAreaLength
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: Math.min(appWindow.width, appWindow.height) / 4 * 3
        contentHeight: areaLengthColumn.height
        property alias spinBoxAreaLength: spinBoxAreaLength
        Column {
            id: areaLengthColumn
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: "ความยาวของพื้นที่"
                width: dialogAreaLength.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            SpinBox {
                id: spinBoxAreaLength
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: fontRegular.name
                to: 1000
                from: 10
                value: farmData.areaLength

                Label {
                    id: labelAreaLengthUnit
                    y: 6
                    text: qsTr("เมตร")
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonAreaLength
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.areaLength = spinBoxAreaLength.value;
                        labelAreaLength.text = spinBoxAreaLength.value;
                        updateZoneCalculationBox();
                        dialogAreaLength.close();
                    }

                }

                Button {
                    id: cancelButtonAreaLength
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogAreaLength.close();
                    }
                }
            }

        }

    }

    Popup {
        id: dialogDripFlowRate
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: Math.min(appWindow.width, appWindow.height) / 5 * 4
        contentHeight: dripFlowRateColumn.height
        property alias spinBoxDripFlowRate: spinBoxDripFlowRate

        Column {
            id: dripFlowRateColumn
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: "อัตราไหลต่อหัวน้ำหยด"
                width: dialogDripFlowRate.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter

            SpinBox {
                id: spinBoxDripFlowRate
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: fontRegular.name
                from: 1
                value: farmData.dripRate*10
                to: 1*100
                property int decimals: 1
                property real realValue: value / 100

                validator: DoubleValidator {
                    bottom: Math.min(spinBoxDripFlowRate.from, spinBoxDripFlowRate.to)
                    top:  Math.max(spinBoxDripFlowRate.from, spinBoxDripFlowRate.to)
                }

                textFromValue: function(value, locale) {
                    return Number(value / 10).toLocaleString(locale, 'f', spinBoxDripFlowRate.decimals)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 10
                }


                Label {
                    id: labelDripFlowRateUnit
                    y: 6
                    text: qsTr("ลิตร/ชม.")
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonDripFlowRate
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.dripRate = spinBoxDripFlowRate.value/10;
                        labelDripFlowRate.text = (spinBoxDripFlowRate.value/10).toFixed(1);
                        updateZoneCalculationBox();
                        dialogDripFlowRate.close();
                    }
                }

                Button {
                    id: cancelButtonDripFlowRate
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogDripFlowRate.close();
                    }
                }
            }

        }
    }

    Popup {
        id: dialogTapeInterval
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: Math.min(appWindow.width, appWindow.height) / 4 * 3
        contentHeight: tapeIntervalColumn.height
        property alias spinBoxTapeInterval: spinBoxTapeInterval

        Column {
            id: tapeIntervalColumn
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                text: "ระยะห่างระหว่างเทปน้ำหยด"
                width: dialogTapeInterval.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            SpinBox {
                id: spinBoxTapeInterval
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: fontRegular.name
                from: 1
                value: farmData.tapeInterval*10
                to: 1*100
                property int decimals: 1
                property real realValue: value / to

                validator: DoubleValidator {
                    bottom: Math.min(spinBoxTapeInterval.from, spinBoxTapeInterval.to)
                    top:  Math.max(spinBoxTapeInterval.from, spinBoxTapeInterval.to)
                }

                textFromValue: function(value, locale) {
                    return Number(value / 10).toLocaleString(locale, 'f', spinBoxTapeInterval.decimals)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 10
                }


                Label {
                    id: labelTapeIntervalUnit
                    y: 6
                    text: qsTr("เมตร")
                    anchors.left: parent.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonTapeInterval
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.tapeInterval = (spinBoxTapeInterval.value/10);
                        labelTapeInterval.text = (spinBoxTapeInterval.value/10).toFixed(1);
                        updateZoneCalculationBox();
                        dialogTapeInterval.close();
                    }
                }

                Button {
                    id: cancelButtonTapeInterval
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogTapeInterval.close();
                    }
                }
            }

        }
    }

    Popup {
        id: dialogPEDiameter
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) / 2
        width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width * 4/6 : appWindow.width*10/11)
        height: peDiameterColumn.height + 20
        property alias tumblerPEDiameter: tumblerPEDiameter
        property alias  labelFlowRateTotal: labelFlowRateTotalD

        Rectangle{
            anchors.fill: parent

        ColumnLayout {
            id: peDiameterColumn
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
            //    Layout.fillWidth: true
                Label{
                    text: "ขนาดของท่อ PE"
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }

                Tumbler {
                    id: tumblerPEDiameter
                    //height: 200
                    //width: dialogPEDiameter.availableWidth
                    //anchors.horizontalCenter: parent.horizontalCenter
                    visibleItemCount: 5
                    model: [16,20,25,32,40,50,63,75,90,110,125]
                    /*delegate: Label{
                        text: "ขนาดท่อ "+diameter+" มม. อัตราไหลสูงสุด "+maxFlowRate+" ลิตร/ชม."
                        width: dialogPEDiameter.availableWidth
                        font.family: fontRegular.name*/

                    currentIndex: farmData.getPEId(farmData.PEDiameter)
                    //currentIndex: farmData.soilId - 1
                    font.family: fontRegular.name
                    font.pixelSize: 17
                    onCurrentIndexChanged: {
                        labelMaxFlowRateD.text = farmData.getPEMaxFlowRate(model[currentIndex]);
                        //console.log("PEDiameter ->  "+ peD +", Max flow ->"+farmData.getPEMaxFlowRate(peD)+", Flow rate total -> "+farmData.flowRateTotal);
                        if(farmData.flowRateTotal < farmData.getPEMaxFlowRate(model[currentIndex]))
                        {
                            labelMaxFlowRateD.color = "green";
                        }
                        else
                        {
                            labelMaxFlowRateD.color = "red";
                        }
                    }
                }
                Label{
                    text: "มิลลิเมตร"
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }
            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: labelMaxFlowRateCaption
                    text: qsTr("อัตราการไหลในท่อ PE สูงสุด")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
                Label {
                    id: labelMaxFlowRateD
                    text: qsTr("50")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }

                Label {
                    id: labelMaxFlowRateUnit
                    text: qsTr("ลิตร/ชม.")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }
/*                ListModel{
                    id: peModel
                    ListElement{
                        diameter: 16
                        maxFlowRate: 1046
                    }
                    ListElement{
                        diameter: 20
                        maxFlowRate: 1635
                    }
                    ListElement{
                        diameter: 25
                        maxFlowRate: 2591
                    }
                    ListElement{
                        diameter: 32
                        maxFlowRate: 4499
                    }
                    ListElement{
                        diameter: 40
                        maxFlowRate: 7009
                    }
                    ListElement{
                        diameter: 50
                        maxFlowRate: 10952
                    }
                    ListElement{
                        diameter: 63
                        maxFlowRate: 17488
                    }
                    ListElement{
                        diameter: 75
                        maxFlowRate: 24792
                    }
                    ListElement{
                        diameter: 90
                        maxFlowRate: 35665
                    }
                    ListElement{
                        diameter: 110
                        maxFlowRate: 53228
                    }
                    ListElement{
                        diameter: 125
                        maxFlowRate: 68701
                    }
                } */
            //}

            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: labelFlowRateTotalCaption
                    text: qsTr("อัตราการไหลของน้ำเข้าโซนที่ต้องการ")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
                Label {
                    id: labelFlowRateTotalD
                    text: farmData.flowRateTotal
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }

                Label {
                    id: labelFlowRateUnit
                    text: qsTr("ลิตร/ชม.")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonPEDiameter
                    text: "Ok"
                    flat: true
                    onClicked: {
                        var peD;
                        peD = tumblerPEDiameter.model[tumblerPEDiameter.currentIndex];
                        farmData.PEDiameter = peD;
                        labelPEDiameter.text = peD;
                        labelMaxFlowRate.text = farmData.getPEMaxFlowRate(peD);
                        labelMaxFlowRateD.color = "green";
                        updateZoneCalculationBox();
                        dialogPEDiameter.close();
                    }
                }

                Button {
                    id: cancelButtonPEDiameter
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogPEDiameter.close();
                    }
                }
            }
            }

        }
    }

    Popup {
        id: dialogSoilType
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: Math.min(appWindow.width, appWindow.height) / 4 * 3
        contentHeight: soilTypeColumn.height
        property alias tumblerSoilType: tumblerSoilType

        Column {
            id: soilTypeColumn
            spacing: 20

            Label {
                text: "ประเภทของดิน"
                width: dialogSoilType.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: labelHoldingCapacityCaption
                    text: qsTr("ดินอุ้มน้ำได้")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
                Label {
                    id: labelHoldingCapacity
                    text: qsTr("1.65")
                    font.family: fontRegular.name
                    font.pixelSize: 17
                }
                Label {
                    id: labelHoldingCapacityUnit
                    x: 6
                    text: qsTr("มม./ชม.")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }

            }

            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: labelAllowableWaterDepletionCaption
                    text: qsTr("ยอมให้น้ำแก่พืชได้")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
                Label {
                    id: labelAllowableWaterDepletion
                    text: qsTr("50")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }

                Label {
                    id: labelAllowableWaterDepletionUnit
                    text: qsTr("%")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }

            Tumbler {
                id: tumblerSoilType
                y: 288
                height: 200
                width: dialogSoilType.availableWidth
                anchors.horizontalCenter: parent.horizontalCenter
                model: ["ดินทราย","ดินร่วนปนทราย","ดินร่วน","ดินร่วนปนตะกอนทราย","ดินร่วนปนเหนียวปนตะกอนทราย","ดินเหนียว"]
                currentIndex: farmData.soilId - 1
                font.family: fontRegular.name
                font.pixelSize: 17
                onCurrentIndexChanged: {
                    farmData.soilId = tumblerSoilType.currentIndex + 1
                    farmData.readSoilInfo();
                    labelHoldingCapacity.text = farmData.holdingCapacity.toFixed(2);
                    labelAllowableWaterDepletion.text = farmData.allowableWaterDepletion.toString();
                }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonSoilType
                    text: "Ok"
                    flat: true
                    onClicked: {
                        labelSoilType.text = tumblerSoilType.model[tumblerSoilType.currentIndex];
                        pageToday.updateTodayWateringList();
                        dialogSoilType.close();
                    }

                }

                Button {
                    id: cancelButtonSoilType
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogSoilType.close();
                    }
                }
            }

        }
    }

    Popup {
        id: dialogStartDate
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width * 0.65 : appWindow.width * 0.9)
        contentHeight: startDateColumn.height
        property alias calendarStartDate: calendarStartDate

        Column {
            id: startDateColumn
            spacing: 20

            Label {
                text: "วันที่เริ่มปลูก"
                width: dialogStartDate.availableWidth
                font.family: fontRegular.name
                font.bold: true
                font.pixelSize: 17
            }

            Calendar {
                id: calendarStartDate
                width: dialogStartDate.availableWidth
                height: 300
                visibleMonth: 8
                navigationBarVisible: true
                frameVisible: true
                dayOfWeekFormat: 1
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
                weekNumbersVisible: true
                selectedDate: farmData.startDate
                property date stopDate: new Date()
                style: CalendarStyle {
                               gridVisible: false
                               dayDelegate: Rectangle {
                                   gradient: Gradient {
                                       GradientStop {
                                           position: 0.00
                                           color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
                                       }
                                       GradientStop {
                                           position: 1.00
                                           color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                                       }
                                       GradientStop {
                                           position: 1.00
                                           color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                                       }
                                   }


                                   Label {
                                       text: styleData.date.getDate()
                                       anchors.centerIn: parent
                                       color: styleData.valid ? "white" : "grey"
                                   }

                                   Rectangle {
                                       width: parent.width
                                       height: 1
                                       color: "#555"
                                       anchors.bottom: parent.bottom
                                   }

                                   Rectangle {
                                       width: 1
                                       height: parent.height
                                       color: "#555"
                                       anchors.right: parent.right
                                   }
                               }
                           }
                onSelectedDateChanged: {
                    labelDialogStartDate.text = Qt.formatDate(selectedDate,"ddd, MMM dd, yyyy");
                    //stopDate = selectedDate;
                    //console.log("Updating startDate -> "+selectedDate+ "+ number of days ->"+farmData.week*7+", getDate -> "+selectedDate.getDate());
                    stopDate = farmData.addDays(selectedDate,farmData.week*7);
                    //console.log("Updating stopDate -> "+stopDate);
                    labelDialogStopDate.text = Qt.formatDate(stopDate, "ddd, MMM dd, yyyy");
                }
            }

            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30
                Label {
                    id: labelStartDateCaption
                    text: qsTr("วันที่เริ่มปลูก")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
                Label {
                    id: labelDialogStartDate
                    text: Qt.formatDate(calendarStartDate.selectedDate,"ddd, MMM dd, yyyy")
                    //text: Qt.formatDate(calendarStartDate.selectedDate,"ddd, MMM dd, yyyy")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }

            }

            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30
                Label {
                    id: labelStopDateCaption
                    text: qsTr("วันสิ้นสุดการปลูก")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                    anchors.leftMargin: 10
                    anchors.left: parent.left
                }
                Label {
                    id: labelDialogStopDate
                    //text: Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy")
                    text: Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy")
                    font.pixelSize: 17
                    font.family: fontRegular.name
                }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Button {
                    id: okButtonStartDate
                    text: "Ok"
                    flat: true
                    onClicked: {
                        farmData.startDate = calendarStartDate.selectedDate;
                        farmData.stopDate = calendarStartDate.stopDate;
                        labelStartDate.text = labelDialogStartDate.text;
                        labelStopDate.text =labelDialogStopDate.text;
                        pageToday.updateTodayWateringList();
                        dialogStartDate.close();
                    }
                }
                Button {
                    id: cancelButtonStartDate
                    text: "Cancel"
                    flat: true
                    onClicked: {
                        dialogStartDate.close();
                    }
                }
            }

        }
    }

}



