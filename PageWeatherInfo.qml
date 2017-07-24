import QtQuick 2.4
import QtPositioning 5.3

PageWeatherInfoForm {
    Component.onCompleted: {
        marker.coordinate = QtPositioning.coordinate(farmData.latitude,farmData.longitude);
        hereMap.center = marker.coordinate;
        updateETpGraph(labelLatitude.text, labelLongitude.text);
    }

    mouseAreaMap.onDoubleClicked: {
        hereMap.center = QtPositioning.coordinate(gpsPosition.position.coordinate.latitude,gpsPosition.position.coordinate.longitude);
    }

    mouseAreaMap.onClicked: {
        console.log("Mouse X:Y ->"+ mouseAreaMap.mouseX + ":" + mouseAreaMap.mouseY);
        busyIndicatorChartViewETp.running = true;
        marker.coordinate = hereMap.toCoordinate(Qt.point(mouseAreaMap.mouseX,mouseAreaMap.mouseY))
        //labelLatitude.text = hereMap.toCoordinate(Qt.point(mouseAreaMap.mouseX,mouseAreaMap.mouseY)).latitude
        labelLatitude.text = marker.coordinate.latitude
        //labelLongitude.text = hereMap.toCoordinate(Qt.point(mouseAreaMap.mouseX,mouseAreaMap.mouseY)).longitude
        labelLongitude.text = marker.coordinate.longitude
        updateETpGraph(labelLatitude.text, labelLongitude.text);
        busyIndicatorChartViewETp.running = false;
    }

/*    buttonGetETp.onClicked: {
        //progressBarGetETp.visible = true;
        busyIndicatorETpChartView.running = true;
        farmData.latitude = labelLatitude.text;
        farmData.longitude = labelLongitude.text;
        farmData.computeETp();
        var ETp = new Array([]);
        //var ETp;
        var day = new Array([]);
        var i;
        for(i=0;i<365;i+=10)
        {
            day.push(i+1);
            //ETp.push(farmData.ETp[i]);
            ETp.push(farmData.getETp(i));
            //barSetETp.values[i] = ETp[i];
            //console.log("FarmData ETp[" + i + "] -> " + ETp[i]);
        }
        barSetETp.values = ETp;
        barCategoriesAxisETp.categories = day;
        pageToday.updateTodayWateringList();
        //progressBarGetETp.visible = false
        busyIndicatorETpChartView.running = false
    }
*/
    /*buttonGetETp.onClicked: {
        updateETpGraph();
    }*/

    function updateETpGraph(latitude,longitude)
    {
        //progressBarGetETp.visible = true;
        //busyIndicatorETpChartView.running = true;
        farmData.latitude = latitude;
        farmData.longitude = longitude;
        farmData.computeETp();
        var i;
        //chartViewETp.removeAllSeries()
        lineSeriesETp.clear();
        for(i=0;i<365;i+=4)
        {
            //day.push(i+1);
            //ETp.push(farmData.ETp[i]);
            //ETp.push(farmData.getETp(i));
            //barSetETp.values[i] = ETp[i];
            //console.log("FarmData ETp[" + i + "] -> " + ETp[i]);
            lineSeriesETp.append(i+1, farmData.getETp(i));
        }
        chartViewETp.update();
        pageToday.updateTodayWateringList();
        //progressBarGetETp.visible = false
        //busyIndicatorETpChartView.running = false
    }

    /*
    buttonGetETp.onClicked: {
        farmData.updateETpGraph();
    } */



    labelLatitude.onTextChanged: {
        farmData.latitude = labelLatitude.text;
    }

    labelLongitude.onTextChanged: {
        farmData.longitude = labelLongitude.text;
    }
}

