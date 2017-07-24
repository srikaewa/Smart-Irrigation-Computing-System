import QtQuick 2.4
//import "KcData.js" as KcData
//import "RootDepthData.js" as RootDepthData

PagePlantDetailForm {
     /*   mouseAreaPlantDetailMenu.onClicked: {
            slidingMenu.drawer.visible = true
        } */

       comboBoxPlantType.onCurrentIndexChanged: {
            selectPlantType(comboBoxPlantType.currentIndex);
            labelPlantDetailHeader.text = "รายละเอียดพืช - " + farmData.plantTitle + " (" + farmData.farmTitle + ")"
           pageFarmDetails.labelFarmDetailHeader.text = farmData.farmTitle +" ("+farmData.plantTitle+")"
            pageFarmDetails.labelStopDate.text = Qt.formatDate(farmData.stopDate,"ddd, MMM dd, yyyy");

        }

        function selectPlantType(index)
        {
            switch(index){
            case 0:
                farmData.plantId = 1;
                lineSeriesKc.name = "มันสำปะหลัง";
                lineSeriesRootDepth.name = "มันสำปะหลัง";
                var i;
                lineSeriesKc.clear();
                lineSeriesRootDepth.clear();
                for(i=0;i<farmData.week;i++)
                {
                    lineSeriesKc.append(i+1,farmData.getKc(i));
                    lineSeriesRootDepth.append(i+1,farmData.getRootDepth(i));
                    //console.log("FarmData Kc[" + i + "] -> " + farmData.Kc[i])
                }
                chartViewKc.update();
                //farmData.setCurrentFarm(farmData.getCurrentFarm());
                pageToday.updateTodayWateringList();
                break;
            case 1:   // อ้อย
                farmData.plantId = 2;
                lineSeriesKc.name = "อ้อย";
                lineSeriesRootDepth.name = "อ้อย";
                var i;
                lineSeriesKc.clear();
                lineSeriesRootDepth.clear();
                for(i=0;i<farmData.week;i++)
                {
                    lineSeriesKc.append(i+1,farmData.getKc(i));
                    lineSeriesRootDepth.append(i+1,farmData.getRootDepth(i));
                    //console.log("FarmData Kc[" + i + "] -> " + farmData.Kc[i])
                }
                chartViewRootDepth.update();
                //farmData.setCurrentFarm(farmData.getCurrentFarm());
                pageToday.updateTodayWateringList();
                break;
            }
        }
}
