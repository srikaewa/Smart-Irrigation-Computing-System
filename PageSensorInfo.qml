import QtQuick 2.4
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import QtQuick.Window 2.0

PageSensorInfoForm {

    Component.onCompleted: {
        getSensorData(textNodeChannel.text);
    }

    Settings{
        property alias sensorChannel1: textFieldSensorChannel1.text
        property alias sensorChannel2: textFieldSensorChannel2.text
        property alias sensorChannel3: textFieldSensorChannel3.text
        property alias sensorChannel4: textFieldSensorChannel4.text
        property alias sensorChannel5: textFieldSensorChannel5.text
        property alias sensorChannel6: textFieldSensorChannel6.text
        property alias sensorChannel7: textFieldSensorChannel7.text
        property alias sensorChannel8: textFieldSensorChannel8.text
        property alias sensorAPIKey1: textFieldSensorAPIKey1.text
        property alias sensorAPIKey2: textFieldSensorAPIKey2.text
        property alias sensorAPIKey3: textFieldSensorAPIKey3.text
        property alias sensorAPIKey4: textFieldSensorAPIKey4.text
        property alias sensorAPIKey5: textFieldSensorAPIKey5.text
        property alias sensorAPIKey6: textFieldSensorAPIKey6.text
        property alias sensorAPIKey7: textFieldSensorAPIKey7.text
        property alias sensorAPIKey8: textFieldSensorAPIKey8.text
        property alias sensorChannel1Selected: radioButtonChannel1.checked
        property alias sensorChannel2Selected: radioButtonChannel2.checked
        property alias sensorChannel3Selected: radioButtonChannel3.checked
        property alias sensorChannel4Selected: radioButtonChannel4.checked
        property alias sensorChannel5Selected: radioButtonChannel5.checked
        property alias sensorChannel6Selected: radioButtonChannel6.checked
        property alias sensorChannel7Selected: radioButtonChannel7.checked
        property alias sensorChannel8Selected: radioButtonChannel8.checked
    }

    function getSensorData(channel)
    {
        getSensor1Data(channel);
        getSensor2Data(channel);
        getSensor3Data(channel);
        getSensor4Data(channel);
        getSensor5Data(channel);
        getSensor6Data(channel);
        getSensor7Data(channel);
        getSensor8Data(channel);
    }

    mouseAreaSensorView1.onClicked: {
        getSensor1Data(textNodeChannel.text);
    }

    mouseAreaSensorView2.onClicked: {
        getSensor2Data(textNodeChannel.text);
    }

    mouseAreaSensorView3.onClicked: {
        getSensor3Data(textNodeChannel.text);
    }
    mouseAreaSensorView4.onClicked: {
        getSensor4Data(textNodeChannel.text);
    }
    mouseAreaSensorView5.onClicked: {
        getSensor5Data(textNodeChannel.text);
    }
    mouseAreaSensorView6.onClicked: {
        getSensor6Data(textNodeChannel.text);
    }
    mouseAreaSensorView7.onClicked: {
        getSensor7Data(textNodeChannel.text);
    }
    mouseAreaSensorView8.onClicked: {
        getSensor8Data(textNodeChannel.text);
    }

    mouseAreaSensorMenuOption.onClicked: {
        dialogSensorSetting.open();
    }



    Popup {
        id: dialogSensorSetting
        modal: true
        focus: true
        x: (appWindow.width - width) / 2
        y: (appWindow.height - height) /2
        //width: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.width * 1/3 : appWindow.width * 2/3)
        //height: (Screen.primaryOrientation == Qt.LandscapeOrientation ? appWindow.height * 0.6 : appWindow.height * 0.5)
        width: groupboxNode.width * 1.1
        height: groupboxNode.height * 1.2

        /*property alias textFieldSensorChannel1: textFieldSensorChannel1.text
        property alias textFieldSensorChannel2: textFieldSensorChannel2.text
        property alias textFieldSensorChannel3: textFieldSensorChannel3.text
        property alias textFieldSensorChannel4: textFieldSensorChannel4.text
        property alias textFieldSensorChannel5: textFieldSensorChannel5.text
        property alias textFieldSensorChannel6: textFieldSensorChannel6.text
        property alias textFieldSensorChannel7: textFieldSensorChannel7.text
        property alias textFieldSensorChannel8: textFieldSensorChannel8.text
        property alias radioGroupNode: radioGroupNode
        property alias radioChannel1: radioButtonChannel1
        property alias radioChannel2: radioButtonChannel2
        property alias radioChannel3: radioButtonChannel3
        property alias radioChannel4: radioButtonChannel4
        property alias radioChannel5: radioButtonChannel5
        property alias radioChannel6: radioButtonChannel6
        property alias radioChannel7: radioButtonChannel7
        property alias radioChannel8: radioButtonChannel8 */

        /*Label{
            text: "ตั้งค่าเครือข่ายเซ็นเซอร์ไร้สาย\n"
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            font.bold: true
            font.pixelSize: 16
            font.family: fontRegular.name
        }*/

        ButtonGroup { id: radioGroupNode }

        GroupBox{
            id: groupboxNode
            title: "ตั้งค่าเครือข่ายเซ็นเซอร์ไร้สาย"
            font.bold: true
            font.pixelSize: 16
            font.family: fontRegular.name
            anchors{
                centerIn: parent
            }
            Grid{
                rows: 8
                columns: 4
                spacing: 5
                anchors{
                    centerIn: parent
                }
                Label{
                    text: "Node #1"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel1
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey1
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel1
                    checked: true
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        textNodeChannel.text = textFieldSensorChannel1.text;
                        getSensorData(textNodeChannel.text);
                    }
                }

                Label{
                    text: "Node #2"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel2
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey2
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel2
                    checked: false
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        textNodeChannel.text = textFieldSensorChannel2.text;
                        getSensorData(textNodeChannel.text);
                    }
                }
                Label{
                    text: "Node #3"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel3
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey3
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel3
                    checked: false
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        textNodeChannel.text = textFieldSensorChannel3.text;
                        getSensorData(textNodeChannel.text);
                    }
                }
                Label{
                    text: "Node #4"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel4
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey4
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel4
                    checked: false
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        textNodeChannel.text = textFieldSensorChannel4.text;
                        getSensorData(textNodeChannel.text);
                    }
                }
                Label{
                    text: "Node #5"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel5
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey5
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel5
                    checked: false
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        textNodeChannel.text = textFieldSensorChannel5.text;
                        getSensorData(textNodeChannel.text);
                    }
                }
                Label{
                    text: "Node #6"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel6
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey6
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel6
                    checked: false
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        textNodeChannel.text = textFieldSensorChannel6.text;
                        getSensorData(textNodeChannel.text);
                    }
                }
                Label{
                    text: "Node #7"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel7
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey7
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel7
                    checked: false
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        nodeChannelSelected = textFieldSensorChannel7.text;
                        getSensorData(textNodeChannel.text);
                    }
                }
                Label{
                    text: "Node #8"
                    font.bold: true
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorChannel8
                    placeholderText: "Channel ID"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                TextField{
                    id: textFieldSensorAPIKey8
                    placeholderText: "API Key"
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 14
                    font.family: fontRegular.name
                }
                RadioButton{
                    id: radioButtonChannel8
                    checked: false
                    ButtonGroup.group: radioGroupNode
                    onClicked: {
                        textNodeChannel.text = textFieldSensorChannel8.text;
                        getSensorData(textNodeChannel.text);
                    }
                }
            }

    }
    }

    function getSensor1Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field1 != null)
                {
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesSensor1.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field1 !== null)
                            {
                                var field1 = parseFloat(""+object.feeds[i].field1);
                                //console.log("Sensor#1["+i+"] = "+object.feeds[i].field1+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesSensor1.append(created_date, field1);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field1 > max_y)
                                    max_y = field1;
                            }
                        }
                    }
                    valueAxisXSensor1.max = max_date;
                    valueAxisXSensor1.min = min_date;
                    valueAxisYSensor1.max = max_y*1.10;
                    chartViewSensor1.title = object.channel.field1;
                    chartViewSensor1.update();
                    busyIndicatorChartViewSensor1.running = false;
                }
            else
                {
                    chartViewSensor1.title = "N/A";
                    busyIndicatorChartViewSensor1.running = false;
                }
            }
            }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/1.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor1.running = true;
    }

//0841070082
    function getSensor2Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field2 != null)
                {
                //console.log("Go JSON!");
                //console.log(JSON.stringify(object, null, 2));
                var ONE_DAY = 1000 * 60 * 60 * 24;
                var updated_date = new Date(object.channel.updated_at);
                var min_date = new Date();
                var max_date = new Date();
                var max_y = 0;
                lineSeriesSensor2.clear();
                for(var i = 0; i < object.feeds.length; i++)
                    {
                    var created_date = new Date(object.feeds[i].created_at);
                    if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                    {
                        if(object.feeds[i].field2 !== null)
                        {
                            var field2 = parseFloat(""+object.feeds[i].field2);
                            //field1 += 10;
                            //console.log("Sensor#1["+i+"] = "+object.feeds[i].field2+" created at " + Qt.formatDate(created_date,"dd MMM"));
                            lineSeriesSensor2.append(created_date, field2);
                            if(min_date.getTime() > created_date.getTime())
                                min_date = created_date;
                            max_date = created_date;
                            if(field2 > max_y)
                                max_y = field2;
                        }
                    }
                }
                valueAxisXSensor2.max = max_date;
                valueAxisXSensor2.min = min_date
                valueAxisYSensor2.max = max_y*1.10;
                chartViewSensor2.title = object.channel.field2;
                chartViewSensor2.update();
                busyIndicatorChartViewSensor2.running = false;
                }
                else
                    {
                        chartViewSensor2.title = "N/A";
                        busyIndicatorChartViewSensor2.running = false;
                    }
                }
            }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/2.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor2.running = true;
    }

    function getSensor3Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field3 != null)
                {
                    //console.log("Go JSON!");
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesSensor3.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field3 !== null)
                            {
                                var field3 = parseFloat(""+object.feeds[i].field3);
                                //field1 += 10;
                                //console.log("Sensor#1["+i+"] = "+object.feeds[i].field2+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesSensor3.append(created_date, field3);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field3 > max_y)
                                    max_y = field3;
                            }
                        }
                    }
                    valueAxisXSensor3.max = max_date;
                    valueAxisXSensor3.min = min_date
                    valueAxisYSensor3.max = max_y*1.10;
                    chartViewSensor3.title = object.channel.field3;
                    chartViewSensor3.update();
                    busyIndicatorChartViewSensor3.running = false;
                    }
                else
                {
                    chartViewSensor3.title = "N/A";
                    busyIndicatorChartViewSensor3.running = false;
                }
            }
            }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/3.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor3.running = true;
    }

    function getSensor4Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field4 != null)
                {
                    //console.log("Go JSON!");
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesSensor4.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field4 !== null)
                            {
                                var field4 = parseFloat(""+object.feeds[i].field4);
                                //field1 += 10;
                                //console.log("Sensor#1["+i+"] = "+object.feeds[i].field2+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesSensor4.append(created_date, field4);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field4 > max_y)
                                    max_y = field4;
                            }
                        }
                    }
                    valueAxisXSensor4.max = max_date;
                    valueAxisXSensor4.min = min_date
                    valueAxisYSensor4.max = max_y*1.10;
                    chartViewSensor4.title = object.channel.field4;
                    chartViewSensor4.update();
                    busyIndicatorChartViewSensor4.running = false;
                }
                else
                {
                    chartViewSensor4.title = "N/A";
                    busyIndicatorChartViewSensor4.running = false;
                }
            }
            }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/4.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor4.running = true;
    }
    function getSensor5Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field5 != null)
                {
                    //console.log("Go JSON!");
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesSensor5.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field5 !== null)
                            {
                                var field5 = parseFloat(""+object.feeds[i].field5);
                                //field1 += 10;
                                //console.log("Sensor#1["+i+"] = "+object.feeds[i].field2+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesSensor5.append(created_date, field5);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field5 > max_y)
                                    max_y = field5;
                            }
                        }
                    }
                    valueAxisXSensor5.max = max_date;
                    valueAxisXSensor5.min = min_date
                    valueAxisYSensor5.max = max_y*1.10;
                    chartViewSensor5.title = object.channel.field5;
                    chartViewSensor5.update();
                    busyIndicatorChartViewSensor5.running = false;
                    }
                else
                {
                    chartViewSensor5.title = "N/A";
                    busyIndicatorChartViewSensor5.running = false;
                }
            }
           }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/5.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor5.running = true;
    }

    function getSensor6Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field6 != null)
                {
                    //console.log("Go JSON!");
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesSensor6.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field6 !== null)
                            {
                                var field6 = parseFloat(""+object.feeds[i].field6);
                                //field1 += 10;
                                //console.log("Sensor#1["+i+"] = "+object.feeds[i].field2+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesSensor6.append(created_date, field6);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field6 > max_y)
                                    max_y = field6;
                            }
                        }
                    }
                    valueAxisXSensor6.max = max_date;
                    valueAxisXSensor6.min = min_date
                    valueAxisYSensor6.max = max_y*1.10;
                    chartViewSensor6.title = object.channel.field3;
                    chartViewSensor6.update();
                    busyIndicatorChartViewSensor6.running = false;
                    }
                else
                {
                    chartViewSensor6.title = "N/A";
                    busyIndicatorChartViewSensor6.running = false;
                }
            }
            }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/6.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor6.running = true;
    }

    function getSensor7Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field7 != null)
                {
                    //console.log("Go JSON!");
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesSensor7.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field7 !== null)
                            {
                                var field7 = parseFloat(""+object.feeds[i].field7);
                                //field1 += 10;
                                //console.log("Sensor#1["+i+"] = "+object.feeds[i].field2+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesSensor7.append(created_date, field7);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field7 > max_y)
                                    max_y = field7;
                            }
                        }
                    }
                    valueAxisXSensor7.max = max_date;
                    valueAxisXSensor7.min = min_date
                    valueAxisYSensor7.max = max_y*1.10;
                    chartViewSensor7.title = object.channel.field7;
                    chartViewSensor7.update();
                    busyIndicatorChartViewSensor7.running = false;
                    }
                else
                {
                    chartViewSensor7.title = "N/A";
                    busyIndicatorChartViewSensor7.running = false;
                }
            }
            }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/7.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor7.running = true;
    }

    function getSensor8Data(channel) {
        var xhr = new XMLHttpRequest();
        //console.log("Enterting JSON request...");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                console.log("HEADER RECEIVED!");
            } else
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var object = JSON.parse(xhr.responseText.toString());
                if(object.channel.field8 != null)
                {
                    //console.log("Go JSON!");
                    //console.log(JSON.stringify(object, null, 2));
                    var ONE_DAY = 1000 * 60 * 60 * 24;
                    var updated_date = new Date(object.channel.updated_at);
                    var min_date = new Date();
                    var max_date = new Date();
                    var max_y = 0;
                    lineSeriesSensor8.clear();
                    for(var i = 0; i < object.feeds.length; i++)
                        {
                        var created_date = new Date(object.feeds[i].created_at);
                        if(created_date.getTime() - updated_date.getTime() <  7*ONE_DAY)
                        {
                            if(object.feeds[i].field8 !== null)
                            {
                                var field8 = parseFloat(""+object.feeds[i].field8);
                                //field1 += 10;
                                //console.log("Sensor#1["+i+"] = "+object.feeds[i].field2+" created at " + Qt.formatDate(created_date,"dd MMM"));
                                lineSeriesSensor8.append(created_date, field8);
                                if(min_date.getTime() > created_date.getTime())
                                    min_date = created_date;
                                max_date = created_date;
                                if(field8 > max_y)
                                    max_y = field8;
                            }
                        }
                    }
                    valueAxisXSensor8.max = max_date;
                    valueAxisXSensor8.min = min_date
                    valueAxisYSensor8.max = max_y*1.10;
                    chartViewSensor8.title = object.channel.field8;
                    chartViewSensor8.update();
                    busyIndicatorChartViewSensor8.running = false;
                    }
                else
                {
                    chartViewSensor8.title = "N/A";
                    busyIndicatorChartViewSensor8.running = false;
                }
            }
            }
        var http_str = "https://thingspeak.com/channels/" + channel +"/field/8.json";
        xhr.open("GET", http_str);
        xhr.send();
        busyIndicatorChartViewSensor8.running = true;
    }
}
