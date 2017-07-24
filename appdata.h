#ifndef APPDATA_H
#define APPDATA_H

#include <QObject>
#include <QtSql>
#include <QTime>

#include <cmath>
#include <bitset>

#include <QQuickView>

#include <QtCharts/QChartView>
#include <QtCharts/QBarSeries>
#include <QtCharts/QBarSet>
#include <QtCharts/QLegend>
#include <QtCharts/QBarCategoryAxis>

#include <QtAndroid>
#include <QAndroidJniObject>

QT_CHARTS_USE_NAMESPACE

struct Zone{
    int zone;
    int valve;

};

struct PESpec{
    int diameter;
    int maxFlowRate;
};

class AppData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool dbstatus READ dbstatus WRITE setDbstatus NOTIFY dbstatusChanged)
    Q_PROPERTY(bool farmDataStatus READ farmDataStatus WRITE setFarmDataStatus NOTIFY farmDataStatusChanged)
    Q_PROPERTY(int farmId READ farmId WRITE setFarmId NOTIFY farmIdChanged)
    Q_PROPERTY(QString pumpChannel READ pumpChannel WRITE setPumpChannel NOTIFY pumpChannelChanged)
    Q_PROPERTY(QString pumpAPIKey READ pumpAPIKey WRITE setPumpAPIKey NOTIFY pumpAPIKeyChanged)
    Q_PROPERTY(float areaWidth READ areaWidth WRITE setAreaWidth NOTIFY areaWidthChanged)
    Q_PROPERTY(float areaLength READ areaLength WRITE setAreaLength NOTIFY areaLengthChanged)
    Q_PROPERTY(float zoneWidth READ zoneWidth WRITE setZoneWidth NOTIFY zoneWidthChanged)
    Q_PROPERTY(float zoneLength READ zoneLength WRITE setZoneLength NOTIFY zoneLengthChanged)
    Q_PROPERTY(int PEDiameter READ PEDiameter WRITE setPEDiameter NOTIFY PEDiameterChanged)
    Q_PROPERTY(int keepScreenOn READ keepScreenOn WRITE setKeepScreenOn NOTIFY keepScreenOnChanged)
    Q_PROPERTY(QString farmTitle READ farmTitle WRITE setFarmTitle NOTIFY farmTitleChanged)
    Q_PROPERTY(float tapeLength READ tapeLength WRITE setTapeLength NOTIFY tapeLengthChanged)
    Q_PROPERTY(float dripInterval READ dripInterval WRITE setDripInterval NOTIFY dripIntervalChanged)
    Q_PROPERTY(float tapeNumber READ tapeNumber WRITE setTapeNumber NOTIFY tapeNumberChanged)
    Q_PROPERTY(float dripRate READ dripRate WRITE setDripRate NOTIFY dripRateChanged)
    Q_PROPERTY(float tapeInterval READ tapeInterval WRITE setTapeInterval NOTIFY tapeIntervalChanged)
    Q_PROPERTY(QDate startDate READ startDate WRITE setStartDate NOTIFY startDateChanged)
    Q_PROPERTY(QDate stopDate READ stopDate WRITE setStopDate NOTIFY stopDateChanged)
    Q_PROPERTY(QString latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)
    Q_PROPERTY(QString longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)
    Q_PROPERTY(int dripPerTape READ dripPerTape WRITE setDripPerTape NOTIFY dripPerTapeChanged)
    Q_PROPERTY(int dripTotal READ dripTotal WRITE setDripTotal NOTIFY dripTotalChanged)
    Q_PROPERTY(float flowRateTotal READ flowRateTotal WRITE setFlowRateTotal NOTIFY flowRateTotalChanged)
    Q_PROPERTY(float waterInGroundPerHour READ waterInGroundPerHour WRITE setWaterInGroundPerHour NOTIFY waterInGroundPerHourChanged)
    Q_PROPERTY(int week READ week WRITE setWeek NOTIFY weekChanged)
    Q_PROPERTY(int plantId READ plantId WRITE setPlantId NOTIFY plantIdChanged)
    Q_PROPERTY(QList<double> Kc READ Kc WRITE setKc NOTIFY KcChanged)
    Q_PROPERTY(QList<double> rootDepth READ rootDepth WRITE setRootDepth NOTIFY rootDepthChanged)
    Q_PROPERTY(QString plantTitle READ plantTitle WRITE setPlantTitle NOTIFY plantTitleChanged)
    Q_PROPERTY(int soilId READ soilId WRITE setSoilId NOTIFY soilIdChanged)
    Q_PROPERTY(QString soilTitle READ soilTitle WRITE setSoilTitle NOTIFY soilTitleChanged)
    Q_PROPERTY(int allowableWaterDepletion READ allowableWaterDepletion WRITE setAllowableWaterDepletion NOTIFY allowableWaterDepletionChanged)
    Q_PROPERTY(float holdingCapacity READ holdingCapacity WRITE setHoldingCapacity NOTIFY holdingCapacityChanged)
    Q_PROPERTY(QList<int> daysToWater READ daysToWater WRITE setDaysToWater NOTIFY daysToWaterChanged)
    Q_PROPERTY(QList<int> minutesToWater READ minutesToWater WRITE setMinutesToWater NOTIFY minutesToWaterChanged)
    Q_PROPERTY(QList<QDate> dateToWater READ dateToWater WRITE setDateToWater NOTIFY dateToWaterChanged)
    Q_PROPERTY(QDate todayWatering READ todayWatering WRITE setTodayWatering NOTIFY todayWateringChanged)
    Q_PROPERTY(QString todayWateringTime READ todayWateringTime WRITE setTodayWateringTime NOTIFY todayWateringTimeChanged)
    Q_PROPERTY(QDate nextWatering READ nextWatering WRITE setNextWatering NOTIFY nextWateringChanged)
    Q_PROPERTY(QString nextWateringTime READ nextWateringTime WRITE setNextWateringTime NOTIFY nextWateringTimeChanged)
    Q_PROPERTY(QList<double> ETp READ ETp WRITE setETp NOTIFY ETpChanged)
    Q_PROPERTY(int wateringCount READ wateringCount WRITE setWateringCount NOTIFY wateringCountChanged)
    Q_PROPERTY(int currentWatering READ currentWatering WRITE setCurrentWatering NOTIFY currentWateringChanged)

public:
    explicit AppData(QObject *parent = 0);
    ~AppData();
    bool dbstatus() const;
    void setDbstatus(const bool &dbstatus);

    bool farmDataStatus() const;
    void setFarmDataStatus(const bool &farmDataStatus);

    void writeSettings();
    void readSettings();

    Q_INVOKABLE void KeepScreenOn(bool on);
    Q_INVOKABLE void updateZoneList();
    Q_INVOKABLE int getZoneTotal();
    Q_INVOKABLE int getZoneX();
    Q_INVOKABLE int getZoneY();
    Q_INVOKABLE QList<Zone> getZoneList();
    Q_INVOKABLE int getPEMaxFlowRate(int diameter);
    Q_INVOKABLE int getPEDiameter(int maxFlowRate);
    Q_INVOKABLE void readPESpec();
    Q_INVOKABLE QList<PESpec> getPESpecList();
    Q_INVOKABLE void addNewFarm(QString newFarmTitle);
    Q_INVOKABLE void deleteFarm(int farmId);
    Q_INVOKABLE QList<QString> getFarmTitleList();
    Q_INVOKABLE int getPEId(int diameter);
    Q_INVOKABLE QList<int> getFarmIdList();
    Q_INVOKABLE int getFarmCount();
    Q_INVOKABLE int getCurrentFarm();
    Q_INVOKABLE void setCurrentFarm(int farmId);
    Q_INVOKABLE void readDataFromDefaultFarm();
    Q_INVOKABLE void updateFarmTitle();
    Q_INVOKABLE void updateFarmId();
    Q_INVOKABLE void readPlantTitle();
    Q_INVOKABLE void readPlantKc();
    Q_INVOKABLE void readPlantRootDepth();
    Q_INVOKABLE void readSoilInfo();
    Q_INVOKABLE void computeWateringSchedule();
    Q_INVOKABLE QDate addDays(QDate adate, int days);
    Q_INVOKABLE bool getTodayWatering();
    Q_INVOKABLE QDate getNextWatering(int index);
    Q_INVOKABLE int  getWateringTime(int index);
    Q_INVOKABLE double getKc(int index);
    Q_INVOKABLE double getRootDepth(int index);
    Q_INVOKABLE bool wateringToDay();
    Q_INVOKABLE void computeETp();
    Q_INVOKABLE double getETp(int index);
    Q_INVOKABLE void readETp();
    Q_INVOKABLE void updateETp();
    Q_INVOKABLE void startPumpTime();
    Q_INVOKABLE void stopPumpTime();
    Q_INVOKABLE QString getPumpTimeElapse();
    Q_INVOKABLE void resetPumpTime();
    Q_INVOKABLE void pausePumpTime();
    Q_INVOKABLE void startValve1Time();
    Q_INVOKABLE void stopValve1Time();
    Q_INVOKABLE QString getValve1TimeElapse();
    Q_INVOKABLE void resetValve1Time();
    Q_INVOKABLE void pauseValve1Time();
    Q_INVOKABLE void startValve2Time();
    Q_INVOKABLE void stopValve2Time();
    Q_INVOKABLE QString getValve2TimeElapse();
    Q_INVOKABLE void resetValve2Time();
    Q_INVOKABLE void pauseValve2Time();

    Q_INVOKABLE QString getBuildNumber();
    Q_INVOKABLE void updateETpGraph();

    QSqlDatabase m_db;

    /**** Farm Details *****/
    int farmId() const;
    void setFarmId(const int &farmId);

    float areaWidth() const;
    void setAreaWidth(const float &areaWidth);

    float areaLength() const;
    void setAreaLength(const float &areaLength);

    float zoneWidth() const;
    void setZoneWidth(const float &zoneWidth);

    float zoneLength() const;
    void setZoneLength(const float &zoneLength);


    int PEDiameter() const;
    void setPEDiameter(const int &PEDiameter);

    int keepScreenOn() const;
    void setKeepScreenOn(const int &keepScreenOn);

    QString pumpChannel() const;
    void setPumpChannel(const QString &pumpChannel);
    QString pumpAPIKey() const;
    void setPumpAPIKey(const QString &pumpAPIKey);

    QString farmTitle() const;
    void setFarmTitle(const QString &farmTitle);

    float tapeLength() const;
    void setTapeLength(const float &tapeLength);

    float dripInterval() const;
    void setDripInterval(const float &dripInterval);


    int tapeNumber() const;
    void setTapeNumber(const int &tapeNumber);

    float dripRate() const;
    void setDripRate(const float &dripRate);

    float tapeInterval() const;
    void setTapeInterval(const float &tapeInterval);

    QDate startDate() const;
    void setStartDate(const QDate &startDate);

    QDate stopDate() const;
    void setStopDate(const QDate &stopDate);


    QString latitude() const;
    void setLatitude(const QString &latitude);

    QString longitude() const;
    void setLongitude(const QString &longitude);

    int dripPerTape() const;
    void setDripPerTape(const int &dripPerTape);

    int dripTotal() const;
    void setDripTotal(const int &dripTotal);

    float flowRateTotal() const;
    void setFlowRateTotal(const float &flowRateTotal);

    float waterInGroundPerHour() const;
    void setWaterInGroundPerHour(const float &waterInGroundPerHour);

    int week() const;
    void setWeek(const int &week);

    QList<double> Kc() const;
    void setKc(const QList<double> &Kc);

    QList<double> rootDepth() const;
    void setRootDepth(const QList<double> &rootDepth);

    int plantId() const;
    void setPlantId(const int &plantId);

    QString plantTitle() const;
    void setPlantTitle(const QString &plantTitle);

    int soilId() const;
    void setSoilId(const int &soilId);

    QString soilTitle() const;
    void setSoilTitle(const QString &soilTitle);

    int allowableWaterDepletion() const;
    void setAllowableWaterDepletion(const int &allowableWaterDepletion);

    float holdingCapacity() const;
    void setHoldingCapacity(const float &holdingCapacity);

    QList<int> daysToWater() const;
    void setDaysToWater(const QList<int> &daysToWater);

    QList<int> minutesToWater() const;
    void setMinutesToWater(const QList<int> &minutesToWater);

    QList<QDate> dateToWater() const;
    void setDateToWater(const QList<QDate> &dateToWater);

    QDate todayWatering() const;
    void setTodayWatering(const QDate &todayWatering);

    QString todayWateringTime() const;
    void setTodayWateringTime(const QString &todayWateringTime);

    QDate nextWatering() const;
    void setNextWatering(const QDate &nextWatering);

    QString nextWateringTime() const;
    void setNextWateringTime(const QString &nextWateringTime);

    int wateringCount() const;
    void setWateringCount(const int &wateringCount);

    QList<double> ETp() const;
    void setETp(const QList<double> &ETp);

    int currentWatering() const;
    void setCurrentWatering(const int & currentWatering);

private:
    QString m_buildNumber = "201706130502";
    bool m_dbstatus = false;
    bool m_farmDataStatus = false;
    int m_farmId=2;

    QString m_pumpChannel = "106494";
    QString m_pumpAPIKey = "1CZJRPGLO28ZTSQW";

    QTime m_pumpOnTime = QTime::currentTime();
    int m_pumpOnMS = 0;

    QTime m_valve1OnTime = QTime::currentTime();
    int m_valve1OnMS = 0;
    QTime m_valve2OnTime = QTime::currentTime();
    int m_valve2OnMS = 0;

    QList<QTime> m_valveTimer;

    float m_areaWidth = 100;
    float m_areaLength = 160;
    float m_zoneWidth = 50;
    float m_zoneLength = 80;
    int m_zoneX;
    int m_zoneY;
    int m_zoneTotal;
    float m_PEDiameter;
    QList<Zone> m_zoneList;
    QList<PESpec> m_PESpec;
    QList<QString> m_farmTitleList;
    QList<int> m_farmIdList;
    QString m_farmTitle = "ฟาร์มเกษตรแม่นยำ";
    float m_tapeLength = 50;
    float m_dripInterval = 0.3;
    int m_tapeNumber = 67;
    float m_dripRate = 1.5;
    float m_tapeInterval = 1.2;
    QDate m_startDate = QDate::currentDate();
    QDate m_stopDate = QDate::currentDate();
    QString m_latitude = "14.896144656693256";
    QString m_longitude = "102.00664336776731";

    int m_keepScreenOn = 0;

    int m_dripPerTape;
    int m_dripTotal;
    float m_flowRateTotal;
    float m_waterInGroundPerHour;

    int m_plantId = 1;
    QString m_plantTitle;
    int m_week;
    QList<double> m_Kc;
    QList<double> m_rootDepth;

    int m_soilId = 1;
    QString m_soilTitle;
    int m_allowableWaterDepletion;
    float m_holdingCapacity;

    QList<int> m_daysToWater;
    QList<int> m_minutesToWater;
    QList<QDate> m_dateToWater;

    QDate m_todayWatering;
    QString m_todayWateringTime;

    QDate m_nextWatering;
    QString m_nextWateringTime;

    int m_wateringCount = 0;
    int m_currentWatering = 0;

    float ma_coefficient = 0.8;

    QList<double> m_ETp = { 3.14,3.15,3.15,3.16,3.17,3.18,3.19,3.2,3.21,3.22,3.23,3.24,3.25,3.26,3.28,3.29,3.3,3.32,3.33,
                     3.35,3.36,3.38,3.4,3.41,3.43,3.45,3.46,3.48,3.5,3.52,3.54,3.56,3.58,3.59,3.61,3.63,
                     3.65,3.67,3.69,3.71,3.73,3.75,3.77,3.79,3.82,3.84,3.86,3.88,3.9,3.92,3.94,3.96,3.98,
                     4,4.02,4.04,4.06,4.09,4.11,4.13,4.15,4.17,4.19,4.21,4.22,4.24,4.26,4.28,4.3,4.32,
                     4.34,4.35,4.37,4.39,4.4,4.42,4.44,4.45,4.47,4.48,4.49,4.51,4.52,4.53,4.55,4.56,4.57,
                     4.58,4.59,4.6,4.61,4.62,4.62,4.63,4.64,4.64,4.65,4.65,4.66,4.66,4.67,4.67,4.67,4.67,
                     4.67,4.67,4.67,4.67,4.67,4.67,4.67,4.67,4.67,4.66,4.66,4.66,4.65,4.65,4.64,4.64,4.63,
                     4.63,4.62,4.62,4.61,4.6,4.6,4.59,4.58,4.58,4.57,4.56,4.55,4.55,4.54,4.53,4.52,4.52,4.51,
                     4.5,4.49,4.48,4.48,4.47,4.46,4.45,4.44,4.43,4.43,4.42,4.41,4.4,4.39,4.39,4.38,4.37,4.36,4.35,
                     4.35,4.34,4.33,4.32,4.32,4.31,4.3,4.29,4.29,4.28,4.27,4.27,4.26,4.25,4.25,4.24,4.23,4.23,
                     4.22,4.21,4.21,4.2,4.2,4.19,4.19,4.18,4.18,4.17,4.17,4.16,4.16,4.15,4.15,4.14,4.14,4.14,
                     4.13,4.13,4.12,4.12,4.12,4.11,4.11,4.1,4.1,4.1,4.09,4.09,4.08,4.08,4.07,4.07,4.06,4.06,4.05,
                     4.05,4.04,4.03,4.03,4.02,4.02,4.01,4,3.99,3.99,3.98,3.97,3.96,3.95,3.95,3.94,3.93,3.92,3.91,
                     3.9,3.89,3.88,3.87,3.86,3.85,3.84,3.84,3.83,3.82,3.81,3.8,3.79,3.78,3.77,3.76,3.76,3.75,3.74,
                     3.73,3.73,3.72,3.71,3.71,3.7,3.7,3.69,3.69,3.68,3.68,3.67,3.67,3.67,3.67,3.66,3.66,3.66,3.66,
                     3.66,3.66,3.66,3.66,3.66,3.66,3.66,3.66,3.66,3.66,3.66,3.67,3.67,3.67,3.67,3.67,3.67,3.67,
                     3.67,3.67,3.67,3.67,3.66,3.66,3.66,3.66,3.65,3.65,3.65,3.64,3.64,3.63,3.63,3.62,3.61,3.61,
                     3.6,3.59,3.58,3.57,3.56,3.55,3.54,3.53,3.52,3.51,3.5,3.49,3.47,3.46,3.45,3.43,3.42,3.41,
                     3.4,3.38,3.37,3.35,3.34,3.33,3.32,3.3,3.29,3.28,3.26,3.25,3.24,3.23,3.22,3.21,3.2,3.19,
                     3.18,3.17,3.16,3.16,3.15,3.14,3.14,3.13,3.13,3.12,3.12,3.12,3.12,3.12,3.12,3.12,3.12,3.12,
                     3.12,3.12,3.13,3.13,3.14,3.14 };

    void connectDB();
    void updateFarmDetails();
    void calculateFarmDetails();
    void backupDBFile();


signals:
    void dbConnected();
    void dbstatusChanged();
    void farmDataStatusChanged();
    void farmIdChanged();
    void pumpChannelChanged();
    void pumpAPIKeyChanged();
    void areaWidthChanged();
    void areaLengthChanged();
    void zoneWidthChanged();
    void zoneLengthChanged();
    void keepScreenOnChanged();
    void PEDiameterChanged();
    void farmTitleChanged();
    void tapeLengthChanged();
    void dripIntervalChanged();
    void tapeNumberChanged();
    void dripRateChanged();
    void tapeIntervalChanged();
    void startDateChanged();
    void stopDateChanged();
    void latitudeChanged();
    void longitudeChanged();
    void dripPerTapeChanged();
    void dripTotalChanged();
    void flowRateTotalChanged();
    void waterInGroundPerHourChanged();
    void weekChanged();
    void KcChanged();
    void rootDepthChanged();
    void plantIdChanged();
    void plantTitleChanged();
    void soilIdChanged();
    void soilTitleChanged();
    void holdingCapacityChanged();
    void allowableWaterDepletionChanged();
    void daysToWaterChanged();
    void minutesToWaterChanged();
    void dateToWaterChanged();
    void todayWateringChanged();
    void todayWateringTimeChanged();
    void nextWateringChanged();
    void nextWateringTimeChanged();
    void wateringCountChanged();
    void ETpChanged();
    void currentWateringChanged();

public slots:
};

#endif // APPDATA_H
