import QtQuick 2.7
//import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.0
import Qt.labs.settings 1.0

PageTodayForm {
    property alias dialogValve1Status: dialogValve1Status
    property alias dialogValve2Status: dialogValve2Status
    property alias dialogPump: dialogPump
    property alias dialogWarning: dialogWarning
    //property alias timerValve1On: timerValve1On
    //property alias timerValve2On: timerValve2On
    property alias timerValve: timerValve
    Component.onCompleted: {
        busyIndicatorWateringUpdate.running = true;
        //farmData.connectDB();
        //farmData.readDataFromDefaultFarm();
        //updateComboBoxTodayFarmList();
        updateTodayWateringList();
        busyIndicatorWateringUpdate.running = false;
        /*console.log("Screen.width -> "+Screen.width);
        console.log("Screen.height -> "+Screen.height);
        console.log("Screen.pixelDensity -> " +Screen.pixelDensity);
        console.log("Screen device pixel ratio -> "+Screen.devicePixelRatio);
        console.log("Screen.desktopAvailableWidth -> " +Screen.desktopAvailableWidth);
        console.log("Screen.desktopAvailableHeight -> " +Screen.desktopAvailableHeight);
        console.log("Screen physical size x -> "+deviceInfo.getPhysicalSize().x);
        console.log("Screen physical size y -> "+deviceInfo.getPhysicalSize().y);*/
        console.log("Device type -> " + deviceInfo.getDeviceType());
    }

    Settings{
        property alias pumpChannel: textFieldPumpChannelNumber.text
        property alias pumpAPI: textFieldPumpAPIKey.text
    }

    /*mouseAreaPumpInfo.onClicked: {
        getPumpData();
        //dialogPumpStatus.textFieldPumpChannelNumber.text = farmData.pumpChannel;
        //dialogPumpStatus.textFieldPumpAPIKey.text = farmData.pumpAPIKey;
        dialogPumpStatus.open();
}*/

    mouseAreaMenuOption.onClicked: {
        optionsMenu.open();
    }

    Timer {
        id: timerPumpOn
            interval: 1000
            running: false
            repeat: true
            onTriggered: {
                labelPumpOnTimer.text = farmData.getPumpTimeElapse();
                //console.log("Timer trigged at time = "+farmData.getPumpTimeElapse());
            }
        }
    Timer{
        id: timerValve
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            console.log("Repeater index ->" + repeaterZone.itemAt(0))
            checkValveOn();
            //repeaterZone.itemAt(0).labelValveOnTimer.text = farmData.getValve1TimeElapse();
            //console.log("Timer trigged at time = "+farmData.getPumpTimeElapse());
        }

    }

    function checkValveOn()
    {
        var switchUncheckedAll = true;
        for(var i=0;i<repeaterZone.count;i++)
        {
            console.log("Check index -> "+repeaterZone.itemAt(i).indexTimer);
            if(repeaterZone.itemAt(i).switchValve.checked)
            {
                console.log("Switch valve["+i+"] checked!");
                switchUncheckedAll = false;
            }
        }
        if(switchUncheckedAll)
        {
            // turn off timer because all switches are unchecked
            timerValve.stop();
            console.log("All switches are unchecked!");
        }
    }

/*    Timer {
        id: timerValve1On
            interval: 1000
            running: false
            repeat: true
            onTriggered: {
                repeaterZone.itemAt(0).labelValveOnTimer.text = farmData.getValve1TimeElapse();
                //console.log("Timer trigged at time = "+farmData.getPumpTimeElapse());
            }
        }
    Timer {
        id: timerValve2On
            interval: 1000
            running: false
            repeat: true
            onTriggered: {
                repeaterZone.itemAt(1).labelValveOnTimer.text = farmData.getValve2TimeElapse();
                //console.log("Timer trigged at time = "+farmData.getPumpTimeElapse());
            }
        } */

    /***************************************************************************
        https://api.thingspeak.com/update?api_key=DNIOX2ZZ0GNZBQFE&amp;field1=0

        pump on  -> field1=0
        pump off -> field1=1

      **************************************************************************/
    function dialResponse() {
     console.log(this.responseText);//should be return value of 1
    }

/*    switchPump.onClicked: {
        var oReq = new XMLHttpRequest();
        oReq.onload = dialResponse;
        if(switchPump.checked)
        {
            oReq.open("get", "https://api.thingspeak.com/update?api_key=F2GJIQFX9YSRLWXU&amp;field5=1", true);
            oReq.send();
            farmData.startPumpTime();
            timerPumpOn.start();
            switchPump.text = "ปั๊มน้ำเปิด"
         }
        else
        {
            oReq.open("get", "https://api.thingspeak.com/update?api_key=F2GJIQFX9YSRLWXU&amp;field5=0", true);
            oReq.send();
            farmData.stopPumpTime();
            timerPumpOn.stop();
            switchPump.text = "ปั๊มน้ำปิด"
        }
}*/
/*    mouseAreaTodayMenu.onClicked: {/*    mouseAreaTodayMenu.onClicked: {

        slidingMenu.drawer.visible = true
    } */


    flickableToday.onContentYChanged:
    {
        //console.log("flickable content y change -> " + flickableToday.contentY);
        if(flickableToday.contentY < -100)
        {
            //busyIndicatorWateringUpdate.running = true;
            updateTodayWateringList();
            labelPullDown.text = "Info Updated!"
            //busyIndicatorWateringUpdate.running = false;
            //console.log("Today page updated!");
        }
    }

    flickableToday.onMovementEnded: {
        labelPullDown.text = "Pull down to refresh..."
    }

    function updateTodayWateringList()
    {
        labelCurrentDate.text = Qt.formatDate(new Date(), "dddd, MMMM dd, yyyy")
        labelTodayDate.text = (!farmData.wateringToDay()) ? "ไม่มี" : Qt.formatDate(farmData.todayWatering,"MMMM dd, yyyy");
        labelTodayWatering.text = farmData.todayWateringTime
        rectangleTodayWatering.color = getDayColor(farmData.todayWatering)

        listModelNextWatering.clear();
        var wateringCount = farmData.wateringCount;
        var dateToWater = new Array([]);
        var i;
        var startWatering;
        if(farmData.wateringToDay())
        {
            startWatering = farmData.currentWatering+1;
        }
        else
            startWatering = farmData.currentWatering;

        for(i=startWatering;i<wateringCount;i++)
        {
            //dateToWater.push(farmData.getNextWatering(i));
            var minutes = farmData.getWateringTime(i);
            var str = "เปิดน้ำ "+ Math.floor(minutes/60) + " ชั่วโมง " + minutes%60 + " นาที";
            listModelNextWatering.append({wateringDate: Qt.formatDate(farmData.getNextWatering(i),"ddd, MMM dd, yyyy"),wateringTime: str, colorDate: getDayColor(farmData.getNextWatering(i))})
        }

        pageToday.gridZoneRectangle.columns = 0;
        pageToday.gridZoneRectangle.rows = 0;
        //console.log("getZoneX -> "+farmData.getZoneX());
        pageToday.gridZoneRectangle.columns = farmData.getZoneX();
        //console.log("getZoneY -> "+farmData.getZoneY());
        pageToday.gridZoneRectangle.rows = farmData.getZoneY();
    }

/*    function updateComboBoxTodayFarmList()
    {
        console.log("Update combobox FarmList from Today...");
        cbTodayFarmItems.clear();
        var farmIdList = farmData.getFarmIdList();
        var farmTitleList = farmData.getFarmTitleList();
        //console.log("Farm Id -> " + farmIdList[0]);
        //console.log("Farm List -> " + farmTitleList[0]);
        var i;
        for(i=0;i< farmTitleList.length;i++)
        {
            cbTodayFarmItems.append({farmId: farmIdList[i],farmTitle: farmTitleList[i]});

            //if(farmIdList[i] == farmData.getCurrentFarm())
            //{
            //    comboBoxTodaySelectFarm.currentIndex = i;
            //}
        }
    }

    comboBoxTodaySelectFarm.onCurrentIndexChanged: {
        var farmIdList = farmData.getFarmIdList();
        var farmTitleList = farmData.getFarmTitleList();
        //console.log("get farmId from comboBox -> " +
        //comboBoxTodaySelectFarm.currentIndex + " " + cbTodayFarmItems.get(comboBoxTodaySelectFarm.currentIndex).farmId);
      if((comboBoxTodaySelectFarm.displayText!==null) && (comboBoxTodaySelectFarm.displayText!==undefined) && (comboBoxTodaySelectFarm.displayText!==""))
        {
            farmData.setCurrentFarm(pageFarmDetails.cbFarmItems.get(comboBoxTodaySelectFarm.currentIndex).farmId);
            pageFarmDetails.labelFarmDetailHeader.text = farmData.farmTitle +" ("+farmData.plantTitle+")"
            // this also calls pageToday.updateTodayWateringList()
            pagePlantDetail.comboBoxPlantType.currentIndex = farmData.plantId - 1;
            pagePlantDetail.labelPlantDetailHeader.text = "รายละเอียดพืช - " + farmData.plantTitle + " (" + farmData.farmTitle + ")";
            //pageToday.updateTodayWateringList();
            var i;
            var currentFarm = farmData.getCurrentFarm();
            for(i=0;i< farmTitleList.length;i++)
              {
              // just display Farm title without doing anything else
                  if(farmIdList[i] == currentFarm)
                  {
                      //comboBoxTodaySelectFarm.displayText = farmTitleList[i];
                      console.log("(PageToday) Combobox select -> " + farmTitleList[i]);
                      comboBoxTodaySelectFarm.currentIndex = i;
                      comboBoxTodaySelectFarm.displayText = farmTitleList[i];
                      pageFarmDetails.comboBoxSelectFarm.displayText = farmTitleList[i];
                  }
              }
        }
      else
      {
          var i;
          console.log("Today ComboBox else...");
          var currentFarm = farmData.getCurrentFarm();
          for(i=0;i< farmTitleList.length;i++)
          {
          // just display Farm title without doing anything else
              if(farmIdList[i] == currentFarm)
                  comboBoxTodaySelectFarm.displayText = farmTitleList[i];
          }
      }
    }
*/
    //0841070082


    function getNextDateWatering(idx)
    {
        var ndw = farmData.todayWatering;
        var accud = 0;
        var i;
        for(i=0;i<idx;i++)
        {
            accud += farmData.daysToWater[i];
        }

        ndw.setDate(ndw.getDate()+accud);
        return ndw;
    }

    function getNextWateringTime(idx,date)
    {
        var today = new Date();
        var str;
        if(date < today)
            str = "เปิดน้ำ " + Math.floor(farmData.minutesToWater[idx]/60) + " ชม. " + farmData.minutesToWater[idx]%60 + " นาที";
        else
            str = "";
        return str;
    }

    function getDayColor(date)
    {
        var colorStr;
        var ind;
        ind = date.getDay();
        switch(ind)
        {
            case 0:
                colorStr = "#EF9A9A";
                break;
            case 1:
                colorStr = "#FFF59D";
                break;
            case 2:
                colorStr = "#F48FB1";
                break;
            case 3:
                colorStr = "#C5E1A5";
                break;
            case 4:
                colorStr = "#FFCC80";
                break;
            case 5:
                colorStr = "#90CAF9";
                break;
            case 6:
                colorStr = "#CE93D8";
                break;
            default:
                colorStr = "#B0BEC5"
        }
        return colorStr;
    }

/*    function getPumpData() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                console.log("Go JSON! -> "+object);
                //console.log(JSON.stringify(object, null, 2));
                var ONE_DAY = 1000 * 60 * 60 * 24;
                var updated_date = new Date(object.channel.updated_at);
                var min_date = new Date();
                var max_date = new Date();
                var max_y = 0;
                lineSeriesPump.clear();
                for(var i = 0; i < object.feeds.length; i++)
                    {
                    var created_date = new Date(object.feeds[i].created_at);
                    if((created_date.getTime()-updated_date.getTime()) <  7*ONE_DAY)
                    {
                        if(object.feeds[i].field3 !== null)
                        {
                            var field3 = parseFloat(""+object.feeds[i].field3);
                            //console.log("MainPump["+i+"] = "+object.feeds[i].field8+" created at " + Qt.formatDate(created_date,"dd MMM"));
                            lineSeriesPump.append(created_date, field3);
                            if(min_date.getTime() > created_date.getTime())
                                min_date = created_date;
                            max_date = created_date;
                            if(field3 > max_y)
                                max_y = field3;
                        }
                    }
                }
                valueAxisXPump.max = max_date;
                valueAxisXPump.min = min_date;
                valueAxisYPump.max = max_y*1.10;
                chartViewPump.title = object.channel.field1;  // Main Pump
                chartViewPump.update();
                }
            }
        var http_str="https://thingspeak.com/channels/"+textFieldPumpChannelNumber.text+"/field/3.json";
        xhr.open("GET", http_str);
        xhr.send();
    } */

/*
    Popup {
        id: dialogPumpStatus
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width * 2/3 : appWindow.width * 7/8)
        height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.height * 0.95 : appWindow.height * 0.75)

        //contentHeight: Screen.height * 4/5
        property alias textFieldPumpChannelNumber: textFieldPumpChannelNumber
        property alias textFieldPumpAPIKey: textFieldPumpAPIKey
        Column {
            id: pumpStatusColumn
            //anchors.horizontalCenter: parent.horizontalCenter
            //color: "#eeeeee"
            Column{
                ChartView {
                    id: chartViewPump
                    title: "สถานะปั๊มน้ำ (เปิด = 1/ปิด = 0)"
                    titleFont: fontRegular.name
                    width: dialogPumpStatus.availableWidth
                    height: dialogPumpStatus.availableHeight*4/6
                    antialiasing: true
                    backgroundColor: "#00FFFFFF"
                    //theme: ChartView.ChartThemeDark
                    //titleColor: Material.theme ? "#FFFFFF" : "#000000"
                    ValueAxis {
                        id: valueAxisYPump
                        min: 0
                        max: 1
                        titleText: "On/Off"
                        titleFont: fontRegular.name
                        labelsFont: Qt.font({pixelSize: 10})
                    }
                    DateTimeAxis{
                        id: valueAxisXPump
                        format: "HH:mm - d MMM"
                        titleText: "วันที่"
                        titleFont: fontRegular.name
                        labelsFont: Qt.font({pixelSize: 10})
                    }

                    LineSeries{
                        id: lineSeriesPump
                        axisY: valueAxisYPump
                        axisX: valueAxisXPump
                    }
                }
            }
            Grid{
                    //width: dialogPumpStatus.availableWidth*0.9
                    rows: 2
                    columns: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    Label{
                        text: "Channel"
                        font.family: fontRegular.name
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                    }
                    TextField{
                        id: textFieldPumpChannelNumber
                        //width: 10
                        //text: farmData.pumpChannel
                        font.family: fontRegular.name
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignTop
                        horizontalAlignment: Text.AlignHCenter
                        width: font.pixelSize*12
                    }
                    Label{
                        text: "API Key"
                        font.family: fontRegular.name
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignVCenter
                    }
                    TextField{
                        id: textFieldPumpAPIKey
                        text: farmData.pumpAPIKey
                        font.family: fontRegular.name
                        font.pixelSize: 16
                        verticalAlignment: Text.AlignTop
                        horizontalAlignment: Text.AlignHCenter
                        width: font.pixelSize*12
                    }
                }

                Button
                {
                    id: updatePumpButton
                    text: "Update"
                    flat: true
                    font.family: fontRegular.name
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        //farmData.pumpChannel = textFieldPumpChannelNumber.text;
                        //farmData.pumpAPIKey = textFieldPumpAPIKey.text;
                        getPumpData();
                    }
                }
             }
            } */
     //   }
    //}

    function getValveData1() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field3 != null)
                {
                    console.log("Go JSON! -> "+object);
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesValve1.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if((created_date.getTime()-updated_date.getTime()) <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field3 !== null)
                            {
                                var field3 = parseFloat(""+object.feeds[i].field3);
                                //console.log("MainPump["+i+"] = "+object.feeds[i].field6+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesValve1.append(created_date, field3);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field3 > max_y)
                                    max_y = field3;
                            }
                        }
                    }
                    valueAxisXValve1.max = max_date;
                    valueAxisXValve1.min = min_date;
                    valueAxisYValve1.max = max_y*1.10;
                    chartViewValve1.title = object.channel.field3;
                    chartViewValve1.update();
                }
                else
                {
                    dialogValve1Status.close();
                    dialogWarning.open();
                }
                }
            }
        var http_str = "https://thingspeak.com/channels/"+textFieldPumpChannelNumber.text+"/field/3.json";
        console.log(http_str);
        xhr.open("GET", http_str);
        xhr.send();
    }

    Popup {
        id: dialogValve1Status
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) / 2
        width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width * 0.7 : appWindow.width * 0.8)
        height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.height * 0.8 : appWindow.height * 0.5)
        //contentHeight: Screen.height * 4/5

        Column {
            id: valve1StatusColumn
            spacing: 10

                ChartView {
                    id: chartViewValve1
                    title: "สถานะวาล์วน้ำ (เปิด = 1/ปิด = 0)"
                    titleFont: fontRegular.name
                    width: dialogValve1Status.availableWidth
                    height: dialogValve1Status.availableHeight*5/6
                    //anchors.fill: parent
                    antialiasing: true
                    backgroundColor: "#00FFFFFF"
                    //theme: ChartView.ChartThemeDark
                    //titleColor: Material.theme ? "#FFFFFF" : "#000000"
                    ValueAxis {
                        id: valueAxisYValve1
                        min: 0
                        max: 1
                        titleText: "On/Off"
                        titleFont: fontRegular.name
                        labelsFont: Qt.font({pixelSize: 10})
                    }
                    DateTimeAxis{
                        id: valueAxisXValve1
         /*               min: 0
                        max: farmData.week*/
                        format: "HH:mm - d MMM"
                        titleText: "วันที่"
                        titleFont: fontRegular.name
                        labelsFont: Qt.font({pixelSize: 10})
                    }

                    LineSeries{
                        id: lineSeriesValve1
                        axisY: valueAxisYValve1
                        axisX: valueAxisXValve1
                    }
                }
                Button {
                    id: refreshPumpButton
                    anchors.horizontalCenter: chartViewValve1.horizontalCenter
                    text: "Refresh"
                    flat: true
                    onClicked: {
                        getValveData1();
                    }
                }

             }
            }
    function getValveData2() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field4 != null)
                {
                    console.log("Go JSON! -> "+object);
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesValve2.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if((created_date.getTime()-updated_date.getTime()) <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field4 !== null)
                            {
                                var field4 = parseFloat(""+object.feeds[i].field4);
                                //console.log("MainPump["+i+"] = "+object.feeds[i].field7+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesValve2.append(created_date, field4);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field4 > max_y)
                                    max_y = field4;
                            }
                        }
                    }
                    valueAxisXValve2.max = max_date;
                    valueAxisXValve2.min = min_date;
                    valueAxisYValve2.max = max_y*1.10;
                    chartViewValve2.title = object.channel.field4;
                    chartViewValve2.update();
                }
                else
                {
                    dialogValve2Status.close();
                    dialogWarning.open();
                }
            }
            }
        var http_str = "https://thingspeak.com/channels/"+textFieldPumpChannelNumber.text+"/field/4.json";
        console.log(http_str);
        xhr.open("GET", http_str);
        xhr.send();
    }

    Popup {
        id: dialogValve2Status
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) / 2
        width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width * 0.7 : appWindow.width * 0.8)
        height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.height * 0.8 : appWindow.height * 0.5)
        //contentHeight: Screen.height * 4/5

        Column {
            id: valve2StatusColumn
            spacing: 10
                ChartView {
                    id: chartViewValve2
                    title: "สถานะวาล์วน้ำ (เปิด = 1/ปิด = 0)"
                    titleFont: fontRegular.name
                    width: dialogValve2Status.availableWidth
                    height: dialogValve2Status.availableHeight*5/6
                    antialiasing: true
                    backgroundColor: "#00FFFFFF"
                    //theme: ChartView.ChartThemeDark
                    //titleColor: Material.theme ? "#FFFFFF" : "#000000"
                    ValueAxis {
                        id: valueAxisYValve2
                        min: 0
                        max: 1
                        titleText: "On/Off"
                        titleFont: fontRegular.name
                        labelsFont: Qt.font({pixelSize: 10})
                    }
                    DateTimeAxis{
                        id: valueAxisXValve2
         /*               min: 0
                        max: farmData.week*/
                        format: "HH:mm - d MMM"
                        titleText: "วันที่"
                        titleFont: fontRegular.name
                        labelsFont: Qt.font({pixelSize: 10})
                    }

                    LineSeries{
                        id: lineSeriesValve2
                        axisY: valueAxisYValve2
                        axisX: valueAxisXValve2
                    }
                }
                Button {
                    id: okPumpButton
                    anchors.horizontalCenter: chartViewValve2.horizontalCenter
                    text: "Refresh"
                    flat: true
                    onClicked: {
                        getValveData2();
                    }
                }
             }
            }

    Popup{
        id: dialogWarning
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: appWindow.width * 0.3
        height: appWindow.height * 0.2
        Label{
            text: "ไม่มีวาล์วน้ำติดตั้ง!!!"
            anchors{
                centerIn: parent
            }

            font.pixelSize: 16
            font.family: fontRegular.name
        }
    }

    Popup {
        id: dialogPump
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        width: (labelPumpChannel.width + textFieldPumpChannelNumber.width)*1.4
        height: (labelPumpChannelControl.height) * 5
        Label{
            id: labelPumpChannelControl
            text: "ตั้งค่าควบคุมปั๊มน้ำ\n"
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            font.bold: true
            font.pixelSize: 14
            font.family: fontRegular.name
        }

        Grid{
            rows: 2
            columns: 2
            spacing: 5
            anchors{
                top: labelPumpChannelControl.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            Label{
                id: labelPumpChannel
                text: "Pump Channel"
                font.pixelSize: 14
                font.family: fontRegular.name
            }
            TextField{
                id: textFieldPumpChannelNumber                
                placeholderText: "Pump Channel"
                font.bold: true
                font.pixelSize: 14
                font.family: fontRegular.name
            }
            Label{
                id: labelPumpAPIKey
                text: "Pump API Key"
                font.pixelSize: 14
                font.family: fontRegular.name
            }
            TextField{
                id: textFieldPumpAPIKey
                placeholderText: "Pump API Key"
                font.bold: true
                font.pixelSize: 14
                font.family: fontRegular.name
            }
        }
    }
}
