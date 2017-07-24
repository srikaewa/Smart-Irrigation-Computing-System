#include "appdata.h"
#include <QQmlApplicationEngine>
#include <QQmlComponent>

#include "Eigen/Dense"
using Eigen::MatrixXd;

AppData::AppData(QObject *parent) : QObject(parent)
{
    connectDB();
    readDataFromDefaultFarm();
    //readPlantKc();
}

AppData::~AppData()
{
    updateFarmDetails();
    updateETp();
    m_db.close();
    KeepScreenOn(false);  // turn the screen on/off flag back to normal
    //backupDBFile();
}

QString AppData::getBuildNumber()
{
    return m_buildNumber;
}

void AppData::writeSettings()
{
    QSettings settings("Suntrust AI House", "Precision Irrigation System Touch");

    settings.beginGroup("MainWindow");
    settings.setValue("farmId", m_farmId);
    settings.endGroup();
}

void AppData::readSettings()
{
    QSettings settings("Suntrust AI House", "Precision Irrigation System Touch");

    settings.beginGroup("MainWindow");
    //resize(settings.value("size", QSize(400, 400)).toSize());
    //move(settings.value("pos", QPoint(200, 200)).toPoint());

    settings.endGroup();
}

void AppData::updateETpGraph()
{
    //![1]
        QBarSet *dataETp = new QBarSet("Jane");

        *dataETp << 1 << 2 << 3 << 4 << 5 << 6;
    //![1]

    //![2]
        QBarSeries *seriesETp = new QBarSeries();
        seriesETp->append(dataETp);
    //![2]

    //![3]
        QChart *chartETp = new QChart();
        chartETp->addSeries(seriesETp);
        chartETp->setTitle("Simple barchart example");
        chartETp->setAnimationOptions(QChart::SeriesAnimations);
    //![3]

    //![4]
        QStringList categories;
        categories << "Jan";
        QBarCategoryAxis *axisETp = new QBarCategoryAxis();
        axisETp->append(categories);
        chartETp->createDefaultAxes();
        chartETp->setAxisX(axisETp, seriesETp);
    //![4]

    //![5]
        chartETp->legend()->setVisible(true);
        chartETp->legend()->setAlignment(Qt::AlignBottom);
    //![5]

    //![6]
        //QQmlEngine engine;
        //QQmlComponent component(&engine, QUrl::fromLocalFile("qrc:/PageWeatherInfoForm.ui.qml"));
        //QQmlComponent component(&engine, QUrl(QStringLiteral("qrc:/PageWeatherInfo.qml")));
        //QObject *object = component.create();
        //QObject *cv = object->findChild<QObject*>("chartViewETpObject");

        QQmlApplicationEngine engine;
        engine.load(QUrl(QStringLiteral("qrc:///PageWeatherInfoForm.ui.qml")));
        QObject *rootObject = engine.rootObjects().first();
        QObject *cv = rootObject->findChild<QObject*>("chartViewETpObject");
        //QObject *cv = rootObject->findChild<QObject*>("rectangleLatLongLabelObject");
        if (cv)
        {
            qDebug() << "chartViewETpObject found...!";
            //cv->setProperty("backgroundColor", "red");
            qDebug() << cv->property("backgroundColor");
            cv->setProperty("backgroundColor","red");
            qDebug() << cv->property("backgroundColor");
            //cv = new QChartView(chartETp);
            //cv->setRenderHint(QPainter::Antialiasing);
        }
        //delete cv;
    //![6]
}


bool AppData::dbstatus() const
{
    return m_dbstatus;
}

void AppData::setDbstatus(const bool &dbstatus)
{
    if(m_dbstatus!=dbstatus)
    {
        m_dbstatus = dbstatus;
        qDebug()<<"C++:dbstatus changed->"<<m_dbstatus;
    }
}



QString AppData::pumpChannel() const
{
    return m_pumpChannel;
}

void AppData::setPumpChannel(const QString &pumpChannel)
{
    if(m_pumpChannel!=pumpChannel)
    {
        m_pumpChannel = pumpChannel;
        qDebug()<<"AppData:: Write pumpChannel...->"<<m_pumpChannel;
    }
}

QString AppData::pumpAPIKey() const
{
    return m_pumpAPIKey;
}

void AppData::setPumpAPIKey(const QString &pumpAPIKey)
{
    if(m_pumpAPIKey!=pumpAPIKey)
    {
        m_pumpAPIKey = pumpAPIKey;
        qDebug()<<"AppData:: Write pumpAPIKey...->"<<m_pumpAPIKey;
    }
}

bool AppData::farmDataStatus() const
{
    return m_farmDataStatus;
}

void AppData::setFarmDataStatus(const bool &farmDataStatus)
{
    if(m_farmDataStatus!=farmDataStatus)
    {
        m_farmDataStatus = farmDataStatus;
        qDebug()<<"AppData:: Read farm data status...->"<<m_farmDataStatus;
    }
}

int AppData::farmId() const
{
    return m_farmId;
}

void AppData::setFarmId(const int &farmId)
{
    if(m_farmId!=farmId)
    {
        m_farmId = farmId;
        qDebug()<<"AppData:: Write farm ID...->"<< m_farmId;
        //readDataFromDefaultFarm();
    }
}

float AppData::areaWidth() const
{
    return m_areaWidth;
}

void AppData::setAreaWidth(const float &areaWidth)
{
    if(m_areaWidth!=areaWidth)
    {
        m_areaWidth = areaWidth;
        qDebug()<<"AppData:: Write area width...->"<< m_areaWidth;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

float AppData::areaLength() const
{
    return m_areaLength;
}

void AppData::setAreaLength(const float &areaLength)
{
    if(m_areaLength!=areaLength)
    {
        m_areaLength = areaLength;
        qDebug()<<"AppData:: Write area length...->"<< m_areaLength;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

float AppData::zoneWidth() const
{
    return m_zoneWidth;
}

void AppData::setZoneWidth(const float &zoneWidth)
{
    if(m_zoneWidth!=zoneWidth)
    {
        m_zoneWidth = zoneWidth;
        qDebug()<<"AppData:: Write zone width...->"<< m_zoneWidth;
    }
}

float AppData::zoneLength() const
{
    return m_zoneLength;
}

void AppData::setZoneLength(const float &zoneLength)
{
    if(m_zoneLength!=zoneLength)
    {
        m_zoneLength = zoneLength;
        qDebug()<<"AppData:: Write zone length...->"<< m_zoneLength;
    }
}


int AppData::PEDiameter() const
{
    return m_PEDiameter;
}

void AppData::setPEDiameter(const int &PEDiameter)
{
    if(m_PEDiameter!=PEDiameter)
    {
        m_PEDiameter = PEDiameter;
        qDebug()<<"AppData:: Write PE Diameter...->"<< m_PEDiameter;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

int AppData::keepScreenOn() const
{
    return m_keepScreenOn;
}

void AppData::setKeepScreenOn(const int &keepScreenOn)
{
    if(m_keepScreenOn!=keepScreenOn)
    {
        m_keepScreenOn = keepScreenOn;
        qDebug()<<"AppData:: Write KeepScreenOn count...->"<< m_keepScreenOn;
    }
}

QString AppData::farmTitle() const
{
    return m_farmTitle;
}

void AppData::setFarmTitle(const QString &farmTitle)
{
    if(m_farmTitle!=farmTitle)
    {
        m_farmTitle = farmTitle;
        qDebug()<<"AppData:: Write farm title...->"<< m_farmTitle;
    }
}

float AppData::tapeLength() const
{
    return m_tapeLength;
}

void AppData::setTapeLength(const float &tapeLength)
{
    if(m_tapeLength!=tapeLength)
    {
        m_tapeLength = tapeLength;
        qDebug()<<"AppData:: Write tape length...->"<< m_tapeLength;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

float AppData::dripInterval() const
{
    return m_dripInterval;
}

void AppData::setDripInterval(const float &dripInterval)
{
    if(m_dripInterval!=dripInterval)
    {
        m_dripInterval = dripInterval;
        qDebug()<<"AppData:: Write drip interval...->"<< m_dripInterval;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

int AppData::tapeNumber() const
{
    return m_tapeNumber;
}

void AppData::setTapeNumber(const int &tapeNumber)
{
    if(m_tapeNumber!=tapeNumber)
    {
        m_tapeNumber = tapeNumber;
        qDebug()<<"AppData:: Write tape number...->"<< m_tapeNumber;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

float AppData::dripRate() const
{
    return m_dripRate;
}

void AppData::setDripRate(const float &dripRate)
{
    if(m_dripRate!=dripRate)
    {
        m_dripRate = dripRate;
        qDebug()<<"AppData:: Write drip rate...->"<< m_dripRate;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

float AppData::tapeInterval() const
{
    return m_tapeInterval;
}

void AppData::setTapeInterval(const float &tapeInterval)
{
    if(m_tapeInterval!=tapeInterval)
    {
        m_tapeInterval = tapeInterval;
        qDebug()<<"AppData:: Write tape interval...->"<< m_tapeInterval;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

QDate AppData::startDate() const
{
    return m_startDate;
}

void AppData::setStartDate(const QDate &startDate)
{
    if(m_startDate!=startDate)
    {
        m_startDate = startDate;
        m_stopDate = startDate.addDays(m_week*7);
        qDebug()<<"AppData:: Write start date...->"<< m_startDate;
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

QDate AppData::stopDate() const
{
    return m_stopDate;
}

void AppData::setStopDate(const QDate &stopDate)
{
    if(m_stopDate!=stopDate)
    {
        m_stopDate = stopDate;
        qDebug()<<"AppData:: Write stop date...->"<< m_stopDate;
    }
}

QString AppData::latitude() const
{
    return m_latitude;
}

void AppData::setLatitude(const QString &latitude)
{
    if(m_latitude!=latitude)
    {
        m_latitude = latitude;
        qDebug()<<"AppData:: Write latitude...->"<< m_latitude;
        computeWateringSchedule();

    }
}

QString AppData::longitude() const
{
    return m_longitude;
}

void AppData::setLongitude(const QString &longitude)
{
    if(m_longitude!=longitude)
    {
        m_longitude = longitude;
        qDebug()<<"AppData:: Write longitude...->"<< m_longitude;
        computeWateringSchedule();
    }
}

int AppData::dripPerTape() const
{
    return m_dripPerTape;
}

void AppData::setDripPerTape(const int &dripPerTape)
{
    if(m_dripPerTape!=dripPerTape)
    {
        m_dripPerTape = dripPerTape;
        qDebug()<<"AppData:: Write drip per tape...->"<< m_dripPerTape;
    }
}

int AppData::dripTotal() const
{
    return m_dripTotal;
}

void AppData::setDripTotal(const int &dripTotal)
{
    if(m_dripTotal!=dripTotal)
    {
        m_dripTotal = dripTotal;
        qDebug()<<"AppData:: Write drip total...->"<< m_dripTotal;
    }
}


float AppData::flowRateTotal() const
{
    return m_flowRateTotal;
}

void AppData::setFlowRateTotal(const float &flowRateTotal)
{
    if(m_flowRateTotal!=flowRateTotal)
    {
        m_flowRateTotal = flowRateTotal;
        qDebug()<<"AppData:: Write flow rate total...->"<< m_flowRateTotal;
    }
}

float AppData::waterInGroundPerHour() const
{
    return m_waterInGroundPerHour;
}

void AppData::setWaterInGroundPerHour(const float &waterInGroundPerHour)
{
    if(m_waterInGroundPerHour!=waterInGroundPerHour)
    {
        m_waterInGroundPerHour = waterInGroundPerHour;
        qDebug()<<"AppData:: Write water in ground per hour...->"<< m_waterInGroundPerHour;
    }
}

int AppData::week() const
{
    return m_week;
}

void AppData::setWeek(const int &week)
{
    if(m_week!=week)
    {
        m_week = week;
        qDebug()<<"AppData:: Write week number...->"<< m_week;
    }
}


QList<double> AppData::Kc() const
{
    return m_Kc;
}

void AppData::setKc(const QList<double> &Kc)
{
    if(m_Kc!=Kc)
    {
        m_Kc = Kc;
        qDebug()<<"AppData:: Write Kc...->"<< m_Kc;
    }
}

QList<double> AppData::rootDepth() const
{
    return m_rootDepth;
}

void AppData::setRootDepth(const QList<double> &rootDepth)
{
    if(m_rootDepth!=rootDepth)
    {
        m_rootDepth = rootDepth;
        qDebug()<<"AppData:: Write root depth...->"<< m_rootDepth;
    }
}

int AppData::plantId() const
{
    return m_plantId;
}

void AppData::setPlantId(const int &plantId)
{
    if(m_plantId!=plantId)
    {
        m_plantId = plantId;
        qDebug()<<"AppData:: Write plant ID...->"<< m_plantId;
        QSqlQuery qry;
        if (qry.prepare("UPDATE Plant SET active = :active WHERE plantId = :plantId")) {
          qry.bindValue(":active", 1);
          qry.bindValue(":plantId",m_plantId);
          if (qry.exec())
            qDebug() << "AppData:: Update plant ID successfully...";
          else
            qDebug() << "AppData:: Update plant ID failed!";
        }
        else
          qDebug() << "AppData:: Update plant ID query broken!";

        // clear other not to active
        if (qry.prepare("UPDATE Plant SET active = :active WHERE plantId != :plantId")) {
            qry.bindValue(":active",0);
            qry.bindValue(":plantId", m_plantId);
          if (qry.exec())
            qDebug() << "AppData:: Clear plant ID successfully...";
          else
            qDebug() << "AppData:: Clear plant ID failed!";
        }
        else
          qDebug() << "AppData:: Clear plant ID query broken!";

        // update farm details

        readPlantTitle();
        readPlantKc();
        readPlantRootDepth();
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

QString AppData::plantTitle() const
{
    return m_plantTitle;
}

void AppData::setPlantTitle(const QString &plantTitle)
{
    if(m_plantTitle!=plantTitle)
    {
        m_plantTitle = plantTitle;
        qDebug()<<"AppData:: Write plant title...->"<< m_plantTitle;
    }
}

int AppData::soilId() const
{
    return m_soilId;
}

void AppData::setSoilId(const int &soilId)
{
    if(m_soilId!=soilId)
    {
        m_soilId = soilId;
        qDebug()<<"AppData:: Write soil ID...->"<< m_soilId;
        QSqlQuery qry;
        if (qry.prepare("UPDATE Soil SET active = :active WHERE soilId = :soilId")) {
          qry.bindValue(":active", 1);
          qry.bindValue(":soilId",m_soilId);
          if (qry.exec())
            qDebug() << "AppData:: Update soil ID successfully...";
          else
            qDebug() << "AppData:: Update soil ID failed!";
        }
        else
          qDebug() << "AppData:: Update soil ID query broken!";

        // clear other not to active
        if (qry.prepare("UPDATE Soil SET active = :active WHERE soilId != :soilId")) {
            qry.bindValue(":active",0);
            qry.bindValue(":soilId", m_soilId);
          if (qry.exec())
            qDebug() << "AppData:: Clear soil ID successfully...";
          else
            qDebug() << "AppData:: Clear soil ID failed!";
        }
        else
          qDebug() << "AppData:: Clear soil ID query broken!";

        readSoilInfo();
        calculateFarmDetails();
        computeWateringSchedule();
    }
}

QString AppData::soilTitle() const
{
    return m_soilTitle;
}

void AppData::setSoilTitle(const QString &soilTitle)
{
    if(m_soilTitle!=soilTitle)
    {
        m_soilTitle = soilTitle;
        qDebug()<<"AppData:: Write soil title...->"<< m_plantTitle;
    }
}

float AppData::holdingCapacity() const
{
    return m_holdingCapacity;
}

void AppData::setHoldingCapacity(const float &holdingCapacity)
{
    if(m_holdingCapacity!=holdingCapacity)
    {
        m_holdingCapacity = holdingCapacity;
        qDebug()<<"AppData:: Write soil holding capacity...->"<< m_holdingCapacity;
    }
}

int AppData::allowableWaterDepletion() const
{
    return m_allowableWaterDepletion;
}

void AppData::setAllowableWaterDepletion(const int &allowableWaterDepletion)
{
    if(m_allowableWaterDepletion!=allowableWaterDepletion)
    {
        m_allowableWaterDepletion = allowableWaterDepletion;
        qDebug()<<"AppData:: Write soil allowable water depletion...->"<< m_allowableWaterDepletion;
    }
}

QList<int> AppData::daysToWater() const
{
    return m_daysToWater;
}

void AppData::setDaysToWater(const QList<int> &daysToWater)
{
    if(m_daysToWater!=daysToWater)
    {
        m_daysToWater = daysToWater;
        qDebug()<<"AppData:: Write days to water...->"<< m_daysToWater;
    }
}

QList<int> AppData::minutesToWater() const
{
    return m_minutesToWater;
}

void AppData::setMinutesToWater(const QList<int> &minutesToWater)
{
    if(m_minutesToWater!=minutesToWater)
    {
        m_minutesToWater = minutesToWater;
        qDebug()<<"AppData:: Write minutes to water...->"<< m_minutesToWater;
    }
}

QList<QDate> AppData::dateToWater() const
{
    return m_dateToWater;
}

void AppData::setDateToWater(const QList<QDate> &dateToWater)
{
    if(m_dateToWater!=dateToWater)
    {
        m_dateToWater = dateToWater;
        qDebug()<<"AppData:: Write date to water...->"<< m_dateToWater;
    }
}

QDate AppData::todayWatering() const
{
    return m_todayWatering;
}

void AppData::setTodayWatering(const QDate &todayWatering)
{
    if(m_todayWatering!=todayWatering)
    {
        m_todayWatering = todayWatering;
        qDebug()<<"AppData:: Write today watering...->"<< m_todayWatering;
    }
}

QString AppData::todayWateringTime() const
{
    return m_todayWateringTime;
}

void AppData::setTodayWateringTime(const QString &todayWateringTime)
{
    if(m_todayWateringTime!=todayWateringTime)
    {
        m_todayWateringTime = todayWateringTime;
        qDebug()<<"AppData:: Write today watering time...->"<< m_todayWateringTime;
    }
}

QDate AppData::nextWatering() const
{
    return m_nextWatering;
}

void AppData::setNextWatering(const QDate &nextWatering)
{
    if(m_nextWatering!=nextWatering)
    {
        m_nextWatering = nextWatering;
        qDebug()<<"AppData:: Write next watering...->"<< m_nextWatering;
    }
}

QString AppData::nextWateringTime() const
{
    return m_nextWateringTime;
}

void AppData::setNextWateringTime(const QString &nextWateringTime)
{
    if(m_nextWateringTime!=nextWateringTime)
    {
        m_nextWateringTime = nextWateringTime;
        qDebug()<<"AppData:: Write next watering time...->"<< m_nextWateringTime;
    }
}

int AppData::wateringCount() const
{
    return m_wateringCount;
}

void AppData::setWateringCount(const int &wateringCount)
{
    if(m_wateringCount!=wateringCount)
    {
        m_wateringCount = wateringCount;
        qDebug()<<"AppData:: Write watering count...->"<< m_wateringCount;
    }
}

QList<double> AppData::ETp() const
{
    return m_ETp;
}

void AppData::setETp(const QList<double> &ETp)
{
    if(m_ETp!=ETp)
    {
        m_ETp = ETp;
        qDebug()<<"AppData:: Write ETp...->"<< m_ETp;
    }
}

int AppData::currentWatering() const
{
    return m_currentWatering;
}

void AppData::setCurrentWatering(const int &currentWatering)
{
    if(m_currentWatering!=currentWatering)
    {
        m_currentWatering = currentWatering;
        qDebug()<<"AppData:: Write current watering...->"<< m_currentWatering;
    }
}

/************** for Android ***************/

/*void AppData::connectDB()
{

    QString homeLocation = QStandardPaths::writableLocation(QStandardPaths::HomeLocation);
    QString dbFilePath = homeLocation + "dbf.sqlite";


    QFile dfile("assets:/cws2.sqlite");
    QFile tfile(dbFilePath);

    if (!tfile.exists())
    {
        QFileInfo info1("assets:/cws2.sqlite");
        qDebug() << "Absolute file path -> " + info1.absoluteFilePath();   // returns "/home/bob/bin/untabify"
        qDebug() << "File size -> " + QString::number(info1.size());

        if(dfile.copy(dbFilePath))
        {
            QFile::setPermissions(dbFilePath,QFile::WriteOwner | QFile::ReadOwner);
            QFileInfo info2(dbFilePath);
            qDebug() << "Absolute file path -> " + info2.absoluteFilePath();   // returns "/home/bob/bin/untabify"
            qDebug() << "File size -> " + QString::number(info2.size());               // returns 56201
            qDebug() << "AppData::connectDB -> Copy database file successfully...";
            m_db = QSqlDatabase::addDatabase("QSQLITE");
            m_db.setDatabaseName(dbFilePath);
            if(!m_db.open())
            {
                qCritical() << "AppData:: Failed to open database!";
                m_dbstatus = false;
            }
              else
            {
                m_db.open();
                qDebug() << "AppData:: Database connected...";
                dfile.close();
                tfile.close();
                m_dbstatus = true;
            }
        }
        else
        {
            qDebug() << "AppData:: Copy file failed!";
        }
    }
    else
    {        
        qDebug() << "AppData::connectDB -> Database file '"+ dbFilePath +"' exists...";
        m_db = QSqlDatabase::addDatabase("QSQLITE");
        m_db.setDatabaseName(dbFilePath);
        if(!m_db.open())
        {
            qCritical() << "AppData:: Failed to open database!";
            m_dbstatus = false;
        }
          else
        {
            m_db.open();
            qDebug() << "AppData:: Database connected...";
            dfile.close();
            tfile.close();
            m_dbstatus = true;
        }

    }
}
*/
/************** Desktop ***************/
/*
void AppData::connectDB()
{
    QString dbFilePath = "dbf.sqlite";
    QFile dfile("cws.sqlite");
    QFile tfile(dbFilePath);

    if (!tfile.exists())
    {
        QFileInfo info1("cws.sqlite");
        qDebug() << "Absolute file path -> " + info1.absoluteFilePath();   // returns "/home/bob/bin/untabify"
        qDebug() << "File size -> " + QString::number(info1.size());

        if(dfile.copy(dbFilePath))
        {
            QFile::setPermissions(dbFilePath,QFile::WriteOwner | QFile::ReadOwner);
            QFileInfo info2(dbFilePath);
            qDebug() << "Absolute file path -> " + info2.absoluteFilePath();   // returns "/home/bob/bin/untabify"
            qDebug() << "File size -> " + QString::number(info2.size());               // returns 56201
            qDebug() << "AppData::connectDB -> Copy database file successfully...";
            m_db = QSqlDatabase::addDatabase("QSQLITE");
            m_db.setDatabaseName(dbFilePath);
            if(!m_db.open())
            {
                qCritical() << "AppData:: Failed to open database!";
                m_dbstatus = false;
            }
              else
            {
                m_db.open();
                qDebug() << "AppData:: Database connected...";
                dfile.close();
                tfile.close();
                m_dbstatus = true;
            }
        }
        else
        {
            qDebug() << "AppData:: Copy file failed!";
        }
    }
    else
    {
        qDebug() << "AppData::connectDB -> Database file '"+ dbFilePath +"' exists...";
        m_db = QSqlDatabase::addDatabase("QSQLITE");
        m_db.setDatabaseName(dbFilePath);
        if(!m_db.open())
        {
            qCritical() << "AppData:: Failed to open database!";
            m_dbstatus = false;
        }
          else
        {
            m_db.open();
            qDebug() << "AppData:: Database connected...";
            dfile.close();
            tfile.close();
            m_dbstatus = true;
        }
    }
}
*/

//----  for Mac OS & Android ----//
void AppData::connectDB()
{
    QString homeLocation = QStandardPaths::writableLocation(QStandardPaths::HomeLocation);
    qDebug() << "Writable location :" + homeLocation;
    QString dbFilePath = homeLocation + "dbf.sqlite";


    QFile dfile(":/cws2.sqlite");
    QFile tfile(dbFilePath);

    if (!tfile.exists())
    {
        QFileInfo info1(":/cws2.sqlite");
        qDebug() << "Absolute file path -> " + info1.absoluteFilePath();   // returns "/home/bob/bin/untabify"
        qDebug() << "File size -> " + QString::number(info1.size());

        if(dfile.copy(dbFilePath))
        {
            QFile::setPermissions(dbFilePath,QFile::WriteOwner | QFile::ReadOwner);
            QFileInfo info2(dbFilePath);
            qDebug() << "Absolute file path -> " + info2.absoluteFilePath();   // returns "/home/bob/bin/untabify"
            qDebug() << "File size -> " + QString::number(info2.size());               // returns 56201
            qDebug() << "AppData::connectDB -> Copy database file successfully...";
            m_db = QSqlDatabase::addDatabase("QSQLITE");
            m_db.setDatabaseName(dbFilePath);
            if(!m_db.open())
            {
                qCritical() << "AppData:: Failed to open database!";
                m_dbstatus = false;
            }
              else
            {
                m_db.open();
                qDebug() << "AppData:: Database connected...";
                dfile.close();
                tfile.close();
                m_dbstatus = true;
            }
        }
        else
        {
            qDebug() << "AppData:: Copy file failed!";
        }
    }
    else
    {
        qDebug() << "AppData::connectDB -> Database file '"+ dbFilePath +"' exists...";
        m_db = QSqlDatabase::addDatabase("QSQLITE");
        m_db.setDatabaseName(dbFilePath);
        if(!m_db.open())
        {
            qCritical() << "AppData:: Failed to open database!";
            m_dbstatus = false;
        }
          else
        {
            m_db.open();
            qDebug() << "AppData:: Database connected...";
            dfile.close();
            tfile.close();
            m_dbstatus = true;
        }

    }
}


void AppData::backupDBFile()
{
    /********** for Android *************************/
    //QString homeLocation = QStandardPaths::writableLocation(QStandardPaths::HomeLocation);
    //QString dbFilePath = homeLocation + "dbf.sqlite";
    //qDebug() << "Home Location -> " + dbFilePath;
    /************************************************/
    /********** for Desktop ***********/
    QString dbFilePath = "dbf.sqlite";
    /**********************************/


    /*********** for Android **********/
    //QFile dfile("assets:/cws2.sqlite");
    /**********************************/
    /*********** for Desktop **********/
    QString destFilePath = "cws.sqlite";
    /**********************************/
    QFile tfile(dbFilePath);
    if(tfile.copy(dbFilePath))
    {
        QFile::setPermissions(dbFilePath,QFile::WriteOwner | QFile::ReadOwner);
        QFileInfo info2(dbFilePath);
        qDebug() << "Absolute file path -> " + info2.absoluteFilePath();   // returns "/home/bob/bin/untabify"
        qDebug() << "File size -> " + QString::number(info2.size());               // returns 56201
        qDebug() << "AppData::connectDB -> Copy database file successfully...";
    }
}

void AppData::readDataFromDefaultFarm()
{
    if(m_dbstatus)
    {

               QSqlQuery q(m_db);
               q.prepare("SELECT * FROM FarmDetails WHERE active = :active");
               //q.prepare("SELECT * FROM FarmDetails WHERE active = 1");
               q.bindValue(":active",1);
               //q.addBindValue(1);
               q.exec();
               if(!q.lastError().isValid())
               {
                   while(q.next())
                   {
                       QString str;
                       m_farmId = q.value(q.record().indexOf("farmId")).toInt();
                       qDebug() << "Farm ID: " + QString::number(m_farmId);
                       m_farmTitle = q.value(q.record().indexOf("farmTitle")).toString();
                       qDebug() << "Farm Title: " + m_farmTitle;
                       m_areaWidth = q.value(q.record().indexOf("areaWidth")).toInt();
                       qDebug() << "Area Width: " + QString::number(m_areaWidth);
                       m_areaLength = q.value(q.record().indexOf("areaLength")).toInt();
                       qDebug() << "Area Length: " + QString::number(m_areaLength);
                       m_PEDiameter = q.value(q.record().indexOf("PEDiameter")).toFloat();
                       qDebug() << "PE Diameter: " + QString::number(m_PEDiameter);
                       m_dripInterval = q.value(q.record().indexOf("dripInterval")).toFloat();
                       qDebug() << "Drip Interval: " + QString::number(m_dripInterval);
                       m_dripRate = q.value(q.record().indexOf("dripRate")).toFloat();
                       qDebug() << "Drip Rate: " + QString::number(m_dripRate);
                       m_tapeInterval = q.value(q.record().indexOf("tapeInterval")).toFloat();
                       qDebug() << "Tape Interval: " + QString::number(m_tapeInterval);
                       str = q.value(q.record().indexOf("startDate")).toString();
                       //qDebug() << "Start date : -> " + str;
                       m_startDate = QDate::fromString(str,"yyyyMMdd");
                       qDebug() << "Start Date: " + m_startDate.toString("ddd, MMM dd, yyyy");
                       m_stopDate = QDate::fromString(q.value(q.record().indexOf("stopDate")).toString(),"yyyyMMdd");
                       qDebug() << "Stop Date: " + m_stopDate.toString();
                       m_latitude = q.value(q.record().indexOf("latitude")).toString();
                       qDebug() << "Latitude: " + m_latitude;
                       m_longitude = q.value(q.record().indexOf("longitude")).toString();
                       qDebug() << "Longitude: " + m_longitude;
                       m_pumpChannel = q.value(q.record().indexOf("pumpChannel")).toString();
                       qDebug() << "Pump Channel: " + m_pumpChannel;
                       m_pumpAPIKey = q.value(q.record().indexOf("pumpAPIKey")).toString();
                       qDebug() << "Pump API Key: " + m_pumpAPIKey;
                       m_plantId = q.value(q.record().indexOf("plantId")).toInt();
                       qDebug() << "Plant ID: " + QString::number(m_plantId);
                       m_soilId = q.value(q.record().indexOf("soilId")).toInt();
                       qDebug() << "Soil ID: " + QString::number(m_soilId);

                   }
                   readPlantTitle();
                   readPlantKc();
                   readPlantRootDepth();
                   readSoilInfo();
                   readPESpec();
                   //qDebug() << "Test PE diameter = 63, max flow rate -> "+QString::number(getPEMaxFlowRate(63));
                   //qDebug() << "Test PE max flow rate = 24792, diameter -> "+QString::number(getPEDiameter(24792));

                   calculateFarmDetails();
                   readETp();
                   computeWateringSchedule();
               }
               else
                qDebug()<<"---db failed to open! , error: "<<q.lastError().text();
               //m_db.close();
    }
}

void AppData::readPlantTitle()
{
    QSqlQuery q(m_db);
    q.prepare("SELECT * FROM Plant WHERE plantId = :plantId");
    q.bindValue(":plantId", m_plantId);
    q.exec();
    if(!q.lastError().isValid())
    {
        while(q.next())
        {
             m_plantTitle = q.value(q.record().indexOf("plantTitle")).toString();
             qDebug() << "Plant: title->" + m_plantTitle;
        }
    }
}

void AppData::readPlantKc()
{
    QSqlQuery q(m_db);
    // read from Plant Root Depth table
    q.prepare("SELECT * FROM Kc WHERE plantId = :plantId");
    q.bindValue(":plantId",m_plantId);
    q.exec();
    if(!q.lastError().isValid())
    {
        double kc;
        m_Kc.clear();
        while(q.next())
        {
             //week = q.value(q.record().indexOf("week")).toInt();
             kc = q.value(q.record().indexOf("kc")).toFloat();
             m_Kc.append(kc);
             //qDebug() << "Kc: week->" + QString::number(week) + ", kc->" + QString::number(kc);
        }
    }
    if(m_week!=m_Kc.count())
    {
        m_week = m_Kc.count();
        qDebug() << "Kc (Number of Week): " + QString::number(m_week);
        m_stopDate = m_startDate.addDays(m_week*7);
        qDebug() << "Stop Date: " + m_stopDate.toString("ddd, MMM dd, yyyy");
    }
    /*for(int i=0;i<m_Kc.count();i++)
    {
     qDebug() << "Week(" + QString::number(i+1) + "), Kc->" + QString::number(m_Kc.value(i));
    }*/

}

QDate AppData::addDays(QDate adate, int days)
{
    return adate.addDays(days);
}

void AppData::readPlantRootDepth()
{
    QSqlQuery q(m_db);
    // read from Plant Root Depth table
    q.prepare("SELECT * FROM RootDepth WHERE plantId = :plantId");
    q.bindValue(":plantId",m_plantId);
    q.exec();
    if(!q.lastError().isValid())
    {

        double rootDepth;
        m_rootDepth.clear();
        while(q.next())
        {
             //week = q.value(q.record().indexOf("week")).toInt();
             rootDepth = q.value(q.record().indexOf("rootDepth")).toFloat();
             m_rootDepth.append(rootDepth);
             //qDebug() << "Kc: week->" + QString::number(week) + ", kc->" + QString::number(kc);
        }
    }
    if(m_week!=m_rootDepth.count())
    {
        m_week = m_rootDepth.count();
        qDebug() << "Root depth (Number of Week): " + QString::number(m_week);
        m_stopDate = m_startDate.addDays(m_week*7);
        qDebug() << "Stop Date: " + m_stopDate.toString();
    }
    /*for(int i=0;i<m_rootDepth.count();i++)
    {
     qDebug() << "Week(" + QString::number(i+1) + "), Root Depth->" + QString::number(m_rootDepth.value(i));
    }*/
}

void AppData::readSoilInfo()
{
    QSqlQuery q(m_db);
    q.prepare("SELECT * FROM Soil WHERE soilId = :soilId");
    q.bindValue(":soilId",m_soilId);
    q.exec();
    if(!q.lastError().isValid())
    {
        while(q.next())
        {
             //m_soilId = q.value(q.record().indexOf("soilId")).toInt();
             //qDebug() << "Soil: ID->" + QString::number(m_soilId);
             m_soilTitle = q.value(q.record().indexOf("soilTitle")).toString();
             qDebug() << "Soil: title->" + m_soilTitle;
             m_holdingCapacity = q.value(q.record().indexOf("holdingCapacity")).toFloat();
             qDebug() << "Soil: holding capacity->" + QString::number(m_holdingCapacity);
             m_allowableWaterDepletion = q.value(q.record().indexOf("allowableWaterDepletion")).toInt();
             qDebug() << "Soil: allowable water depletion->" + QString::number(m_allowableWaterDepletion);
        }
    }
}

void AppData::addNewFarm(QString newFarmTitle)
{
    QSqlQuery qry;
    if (qry.prepare("INSERT INTO FarmDetails DEFAULT VALUES")) {
      //qry.bindValue(":farmTitle", m_farmTitle);
      if (qry.exec())
      {
        qDebug() << "AppData:: Add new farm title successfully...";
        if(qry.prepare("SELECT seq FROM sqlite_sequence WHERE name=:name"))
        {
            qry.bindValue(":name","FarmDetails");
            if(qry.exec())
            {
                qDebug() << "AppData:: Access last insert row successfully!";
                if(!qry.lastError().isValid())
                {
                    while(qry.next())
                    {
                    QString str = qry.value(0).toString();
                    qDebug() << "QRY -> " + str;
                    m_farmId = str.toInt();
                    m_farmTitle = newFarmTitle;
                    qDebug() << "Update farmId: "+QString::number(m_farmId) + "farmTitle: "+m_farmTitle;
                    updateFarmId();
                    updateFarmTitle();
                    setCurrentFarm(m_farmId);
                    }
                }
            }
            else
                qDebug() << "AppData:: Access last insert row failed!";
        }else
            qDebug() << "AppData:: Access last insert row query broken!";
      }
      else
        qDebug() << "AppData:: Add new farm title failed!";
    }
    else
      qDebug() << "AppData:: Add new farm title query broken!";
}

void AppData::deleteFarm(int farmId)
{
    // only delete current farm
    QSqlQuery qry;
    if (qry.prepare("DELETE FROM FarmDetails WHERE farmId=:farmId")) {
      qry.bindValue(":farmId", m_farmId);
      if (qry.exec())
      {
        qDebug() << "AppData:: Delete current farm query successfully...";
      }
      else
          qDebug() << "AppData:: Delete current farm failed!";

    }else
    {
        qDebug() << "AppData:: Delete current farm query broken!";
    }
    m_farmId = m_farmIdList.first();  // to prevent update previous farm
    setCurrentFarm(m_farmIdList.first());
}

void AppData::updateFarmTitle()
{
    QSqlQuery qry;
    if (qry.prepare("UPDATE FarmDetails SET farmTitle = :farmTitle WHERE farmId = :farmId")) {
      qry.bindValue(":farmId", m_farmId);
      qry.bindValue(":farmTitle", m_farmTitle);
      if (qry.exec())
        qDebug() << "AppData:: Update farm title successfully...";
      else
        qDebug() << "AppData:: Update farm title failed!";
    }
    else
      qDebug() << "AppData:: Update farm title query broken!";
}

void AppData::updateFarmDetails()
{
    QSqlQuery qry;
    if (qry.prepare("UPDATE FarmDetails SET farmTitle=:farmTitle, areaWidth=:areaWidth, areaLength=:areaLength, PEDiameter=:PEDiameter, dripInterval=:dripInterval, dripRate=:dripRate, tapeInterval=:tapeInterval, plantId=:plantId, soilId=:soilId, startDate=:startDate, stopDate=:stopDate, latitude=:latitude, longitude=:longitude, pumpChannel=:pumpChannel, pumpAPIKey=:pumpAPIKey WHERE farmId=:farmId"))
    {
      //qry.bindValue(":farmId", m_farmId);
      qry.bindValue(":farmTitle", m_farmTitle);
      qry.bindValue(":areaWidth", m_areaWidth);
      qry.bindValue(":areaLength", m_areaLength);
      qry.bindValue(":PEDiameter", m_PEDiameter);
      qry.bindValue(":dripInterval", m_dripInterval);
      qry.bindValue(":dripRate", m_dripRate);
      qry.bindValue(":tapeInterval", m_tapeInterval);
      qry.bindValue(":plantId", m_plantId);
      qry.bindValue(":soilId", m_soilId);
      qry.bindValue(":startDate", m_startDate.toString("yyyyMMdd"));
      qry.bindValue(":stopDate", m_stopDate.toString("yyyyMMdd"));
      qry.bindValue(":latitude", m_latitude);
      qry.bindValue(":longitude",m_longitude);
      qry.bindValue(":pumpChannel", m_pumpChannel);
      qry.bindValue(":pumpAPIKey",m_pumpAPIKey);
      qry.bindValue(":farmId", m_farmId);
      if (qry.exec())
      {
        qDebug() << "AppData:: Update farm["+m_farmTitle+"] details successfully...";
        //calculateFarmDetails();
        //computeWateringSchedule();
      }
      else
        qDebug() << "AppData:: Update farm details failed!";
    }
    else
      qDebug() << "AppData:: Update farm details query broken!";
}

void AppData::updateETp()
{
    QSqlQuery qry;
    qry.prepare("BEGIN TRANSACTION");
    qry.exec();

    if (qry.prepare("UPDATE ETp SET ETp=:ETp WHERE Id=:Id"))
    {
      for(int i=0;i<365;i++)
        {
          qry.bindValue(":ETp", m_ETp[i]);
          qry.bindValue(":Id", i+1);

          if (qry.exec())
          {
            //qDebug() << "AppData:: Update ETp[day="+QString::number(i+1)+"] successfully...";
          }
          //else
            //qDebug() << "AppData:: Update ETp failed!";
        }
      // for day 366
      qry.bindValue(":ETp", m_ETp[364]);
      qry.bindValue(":Id", 366);
      if (qry.exec())
      {
        //qDebug() << "AppData:: Update ETp[day=366] successfully...";
      }
      //else
        //qDebug() << "AppData:: Update ETp failed!";

      qry.prepare("COMMIT");
      qry.exec();
    }
    else
      qDebug() << "AppData:: Update ETp query broken!";
}

void AppData::calculateFarmDetails()
{ 
    int zone_num_x = 0, zone_num_y = 1;
    qDebug()<<"AppData:: Calculate farm details...";
    if(m_areaWidth > 100)
    {
        zone_num_y = ceil(m_areaWidth/100);
        qDebug()<<"AppData:: zone number y -> " + QString::number(zone_num_y);
        m_zoneWidth = floor(m_areaWidth/zone_num_y);
    }
    else
    {
        zone_num_y = 1;
        m_zoneWidth = m_areaWidth;
    }

    m_tapeLength = m_zoneWidth;
    qDebug()<<"AppData:: Tape length = zone width -> " + QString::number(m_tapeLength);

    m_dripPerTape = m_tapeLength/m_dripInterval;
    qDebug()<<"AppData:: Drip per tape -> " + QString::number(m_dripPerTape);

    do{
        ++zone_num_x;
        m_zoneLength = m_areaLength/zone_num_x;
        qDebug()<<"AppData:: Zone length ->" + QString::number(m_zoneLength);
        m_tapeNumber = floor(m_zoneLength/m_tapeInterval);
        qDebug()<<"AppData:: Tape number -> " + QString::number(m_tapeNumber);
        m_dripTotal = m_dripPerTape*m_tapeNumber;
        qDebug()<<"AppData:: Drip total -> " + QString::number(m_dripTotal);
        m_flowRateTotal = ceil(m_dripTotal*m_dripRate);
        qDebug()<<"AppData:: Flow rate total -> " + QString::number(m_flowRateTotal,'g',5);
        qDebug()<<"AppData:: Zone x number -> " + QString::number(zone_num_x);
    }while(m_flowRateTotal > getPEMaxFlowRate(m_PEDiameter));

    m_waterInGroundPerHour = m_flowRateTotal/(m_tapeLength*m_tapeInterval*(m_tapeNumber-1));
    qDebug()<<"AppData:: Water in ground per hour -> " + QString::number(m_waterInGroundPerHour,'g',5);
    qDebug() << "AppData:: Calculate farm details successfully...";
    m_zoneTotal = zone_num_x * zone_num_y;
    m_zoneX = zone_num_x;
    m_zoneY = zone_num_y;
}

int AppData::getZoneX()
{
    return m_zoneX;
}

int AppData::getZoneY()
{
    return m_zoneY;
}

void AppData::computeWateringSchedule()
{
    int week;
    int day;
    QDate date = m_startDate;
    int doy = date.dayOfYear()-1;
    float plantAllowance[m_week];
    float ETc[366] = {0};
    float dtw = 0;
    float mtw = 0;
    float accuETc = 0;
    qDebug() << "Start computing watering schedule...";
    for(week=0;week<m_week;week++)
    {
        plantAllowance[week] = m_holdingCapacity*m_rootDepth[week]*m_allowableWaterDepletion/100;
        //qDebug() << "AppData::computeWaterSchedule planAllowance["+QString::number(week)+"] of " + QString::number(m_week) + " was computed...";
    }
    //qDebug() << "Day of year:: " + QString::number(doy) + " at date:: " + date.toString("ddd, MMM dd, yyyy");
    for(day=doy;day<doy+m_week*7;day++)
    {
        if(day < 365)
        {
            ETc[day] = m_Kc[floor((day-doy)/7)]*m_ETp[day];
            //qDebug() << "AppData::computeWaterSchedule ETc[" +QString::number(day)+"] was computed...";
        }
        else
        {
            ETc[day - 365] = m_Kc[floor((day-doy)/7)]*m_ETp[day - 365];
            //qDebug() << "AppData::computeWaterSchedule ETc[" +QString::number(day - 365)+"] was computed...";
        }

    }
    ETc[365] = ETc[364];
    m_daysToWater.clear();
    m_minutesToWater.clear();
    m_dateToWater.clear();
    day = date.dayOfYear()-1;
    int week_1st = floor(day/7);
    while (date < m_stopDate)
    {
        week = floor(day/7);
        dtw = round(plantAllowance[week-week_1st]/ETc[day]);
        m_daysToWater.append(dtw);
        //m_dateToWater.append(date.toString("ddd, MM dd, yyyy"));
        m_dateToWater.append(date);
        //qDebug() << "computeWateringSchedule: " + date.toString("MMM dd, yyyy") + " -> Days to next watering -> " + QString::number(dtw);
        //qDebug() << "computeWateringScheduoe: Date -> " + m_dateToWater.
        // accumulate ETc
        for(int i=0;i<dtw;i++)
        {
            if(day + i > 365)
            {
                day = 0;
                week_1st = 0;
            }
            accuETc+=ETc[day+i];
        }
        mtw = round(accuETc*60/m_waterInGroundPerHour);
        m_minutesToWater.append(mtw);
        //qDebug() << "computeWateringSchedule: Minutes to water -> " + QString::number(mtw);
        accuETc = 0;
        date = date.addDays(static_cast<int>(dtw));
        //qDebug() << "computeWateringSchedule: day=" + QString::number(day) + " successfully...";
        day += dtw-1;
    }
    m_wateringCount = m_dateToWater.size();
    //qDebug() << "computeWateringSchedule: watering count -> " + QString::number(m_wateringCount);
    /*for(int i=0;i<m_wateringCount;i++)
    {
       qDebug() << "computeWateringSchedule: watering date[" + QString::number(i) + "] = " + m_dateToWater[i].toString("ddd, MMM dd, yyyy");
    }*/
    getTodayWatering();
    qDebug() << "Finished computing watering schedule.";
}

bool AppData::getTodayWatering()
{
    QDate s = QDate::currentDate();
    QDate ns;
    int ss = m_dateToWater.indexOf(s);
    if(ss == -1)
    {
        m_todayWatering = QDate::fromString("20000230","yyyyMMdd");
        m_todayWateringTime = "ไม่มี";
        foreach(ns,m_dateToWater)
        {
            //qDebug() << "For each : ns -> " + ns.toString("ddd, MMM dd, yyyy");
            if(ns > s)
            {
                m_nextWatering = ns;
                ss = m_dateToWater.indexOf(ns);
                m_nextWateringTime = "เปิดน้ำ " + QString::number(floor(m_minutesToWater.at(ss)/60)) + " ชม. " + QString::number(m_minutesToWater.at(ss)%60) + " นาที";
                m_currentWatering = ss;
                break;
            }
        }

        return false;
    }
    else
    {
        m_todayWatering = s;
        m_todayWateringTime = "เปิดน้ำ " + QString::number(floor(m_minutesToWater.at(ss)/60)) + " ชม. " + QString::number(m_minutesToWater.at(ss)%60) + " นาที";
        //qDebug() << "getTodayWatering:: date -> " + s.toString("ddd, MMM dd, yyyy") + ", time -> " + m_todayWateringTime;

        m_nextWatering = m_dateToWater.at(ss + 1);
        m_nextWateringTime = "เปิดน้ำ " + QString::number(floor(m_minutesToWater.at(ss+1)/60)) + " ชม. " + QString::number(m_minutesToWater.at(ss+1)%60) + " นาที";
        m_currentWatering = ss;
        return true;
    }
}

QDate AppData::getNextWatering(int index)
{
    if(index >= 0 && index <m_wateringCount)
        //return m_dateToWater[index].toString("ddd, MMM dd, yyyy");
        return m_dateToWater[index];
    else
        return QDate::currentDate();
}

int AppData::getWateringTime(int index)
{
    if(index >= 0 && index <m_wateringCount)
        //return m_dateToWater[index].toString("ddd, MMM dd, yyyy");
        return m_minutesToWater[index];
    else
        return 0;
}

double AppData::getKc(int index)
{
    if(index>=0 && index<m_week)
        return m_Kc[index];
    else
        return -1;
}

double AppData::getRootDepth(int index)
{
    if(index>=0 && index<m_week)
        return m_rootDepth[index];
    else
        return -1;
}

bool AppData::wateringToDay()
{
    if(m_todayWatering.isValid())
        return true;
    else
        return false;
}

QList<Zone> AppData::getZoneList()
{
    Zone zone = {1,6};
    QSqlQuery q(m_db);
    q.prepare("SELECT * FROM Zone WHERE farmId=:farmId");
    q.bindValue(":farmId", m_farmId);
    q.exec();
    if(!q.lastError().isValid())
    {
        m_zoneList.clear();
        while(q.next())
        {
            zone.zone = q.value(q.record().indexOf("zone")).toInt();
            zone.valve = q.value(q.record().indexOf("valve")).toInt();
            m_zoneList.append(zone);
            //qDebug() << "Farm Id->" +m_farmIdList.last().toString();
        }
        return m_zoneList;
    }
    else
    {
        qDebug() << "AppData::getZoneList SQL error -> " + q.lastError().text();
        return QList<Zone>() << zone;
    }
}

void AppData::updateZoneList()
{

}

int AppData::getZoneTotal()
{
    return m_zoneTotal;
}

void AppData::readPESpec()
{
    PESpec pe = {-1,-1};
    QSqlQuery q(m_db);
    q.prepare("SELECT * FROM PESpec");
    q.exec();
    if(!q.lastError().isValid())
    {
        m_PESpec.clear();
        while(q.next())
        {
            pe.diameter = q.value(q.record().indexOf("diameter")).toInt();
            pe.maxFlowRate = q.value(q.record().indexOf("maxFlowRate")).toInt();
            m_PESpec.append(pe);
            qDebug() << "PE diameter->" +QString::number(m_PESpec.last().diameter)+", max flow rate->"+QString::number(m_PESpec.last().maxFlowRate);
        }
    }
    else
    {
        qDebug() << "AppData::getPESpec SQL error -> " + q.lastError().text();
    }
}

int AppData::getPEMaxFlowRate(int diameter)
{
    PESpec pe;
    int i;
    for(i=0;i<m_PESpec.length();i++)
    {
        if(m_PESpec.at(i).diameter == diameter)
        {
            return m_PESpec.at(i).maxFlowRate;
        }
    }
    return -1;
}

int AppData::getPEDiameter(int maxFlowRate)
{
    PESpec pe;
    int i;
    for(i=0;i<m_PESpec.length();i++)
    {
        if(m_PESpec.at(i).maxFlowRate == maxFlowRate)
        {
            return m_PESpec.at(i).diameter;
        }
    }
    return -1;

}

QList<int> AppData::getFarmIdList()
{
    int item;
    QSqlQuery q(m_db);
    q.prepare("SELECT * FROM FarmDetails");
    q.exec();
    if(!q.lastError().isValid())
    {
        m_farmIdList.clear();
        while(q.next())
        {
            item = q.value(q.record().indexOf("farmId")).toInt();
            m_farmIdList.append(item);
            //qDebug() << "Farm Id->" +m_farmIdList.last().toString();
        }
        return m_farmIdList;
    }
    else
    {
        qDebug() << "AppData::getFarmList SQL error -> " + q.lastError().text();
        return QList<int>() << -1;
    }
}

QList<PESpec> AppData::getPESpecList()
{
    return m_PESpec;
}

int AppData::getPEId(int diameter)
{
    for(int i=0;i<m_PESpec.length();i++)
    {
        if(diameter == m_PESpec.at(i).diameter)
        {
            return i;
        }
    }
    return -1;
}

QList<QString> AppData::getFarmTitleList()
{
    QString item;
    QSqlQuery q(m_db);
    q.prepare("SELECT * FROM FarmDetails");
    q.exec();
    if(!q.lastError().isValid())
    {
        m_farmTitleList.clear();
        while(q.next())
        {
            item = q.value(q.record().indexOf("farmTitle")).toString();
            m_farmTitleList.append(item);
            qDebug() << "Farm Title->" +m_farmTitleList.last();
        }
        return m_farmTitleList;
    }
    else
    {
        qDebug() << "AppData::getFarmList SQL error -> " + q.lastError().text();
        return QList<QString>() << "None";
    }
}

int AppData::getFarmCount()
{
    return m_farmTitleList.count();
}

int AppData::getCurrentFarm()
{
    qDebug() << "AppData::getCurrentFarm -> "+QString::number(m_farmId);
    return m_farmId;
}

void AppData::setCurrentFarm(int farmId)
{
    // update current farm details
    if(m_farmId != farmId)
        updateFarmDetails();
    m_farmId = farmId;
    qDebug() << "AppData::setCurrentFarm -> "+QString::number(m_farmId);
    // update new farm details
    updateFarmId();
    readDataFromDefaultFarm();
}

void AppData::updateFarmId()
{
    QSqlQuery qry;
    if (qry.prepare("UPDATE FarmDetails SET active = :active WHERE farmId = :farmId")) {
      qry.bindValue(":active",1);
      qry.bindValue(":farmId", m_farmId);
      if (qry.exec())
      {
        qDebug() << "AppData:: Update farm Id successfully...";
        if (qry.prepare("UPDATE FarmDetails SET active = :active WHERE farmId != :farmId")) {
          qry.bindValue(":active",0);
          qry.bindValue(":farmId", m_farmId);
          if (qry.exec())
            qDebug() << "AppData:: Clear farm Id successfully...";
          else
            qDebug() << "AppData:: Clear farm Id failed!";
        }
        else
          qDebug() << "AppData:: Clear farm Id query broken!";
        //readDataFromDefaultFarm();
      }
      else
        qDebug() << "AppData:: Update farm Id failed!";
    }
    else
      qDebug() << "AppData:: Update farm Id query broken!";
}

void AppData::computeETp()
{
    MatrixXd iw(15,3);
    MatrixXd b1(15,1);
    MatrixXd lw1(15,15);
    MatrixXd b2(15,1);
    MatrixXd lw2(15,15);
    MatrixXd b3(15,1);
    MatrixXd lw3(15,15);
    MatrixXd b4(15,1);
    MatrixXd lw4(15,15);
    MatrixXd b5(15,1);
    MatrixXd lw5(15,15);
    MatrixXd b6(15,1);
    MatrixXd lw6(15,15);
    MatrixXd b7(15,1);
    MatrixXd lw7(1,15);
    MatrixXd b8(1,1);

    iw << 1.3993, 2.6755, 0.33961,
    1.389, 0.26692, 0.47701,
    0.32262, -1.981, -2.6355,
    -0.16356, 1.4173, 1.5602,
    -0.036845, 0.63804, -2.4789,
    0.61226, 3.2486, 0.59816,
    1.0333, 1.3391, 2.0899,
    0.58596, -1.6811, -1.5383,
    -1.463, 2.241, -0.92349,
    -0.42268, 0.79165, 2.5418,
    -1.1906, -2.323, 0.56014,
    -1.1095, -1.1904, -1.402,
    -0.94914, -1.6981, 1.134,
    -1.4727, 1.2531, -0.25905,
    -1.4455, 0.93214, -2.7018;

    lw1 << 0.37596, 0.4721, 0.1138, -0.41975, -0.091968, -0.30411, -0.74709, 0.019748, 0.43862, 0.21732, -0.1974, 0.94791, 0.5887, 0.090734, 0.32761,
    -1.1631, 1.0973, 0.20342, 0.31228, -0.24975, 0.3944, 0.48992, -0.25558, 0.51101, -0.3463, 0.056507, 0.9869, 0.71951, 1.1342, -0.11454,
    -0.59313, -0.60499, 0.42656, -0.23219, -0.21068, 0.77032, -0.27506, -0.52354, 0.64233, -0.1009, -0.28191, -1.3504, 0.90498, -0.048677, 0.79026,
    -0.08277, 1.44, 0.18266, 1.0812, 0.27378, 0.4319, 0.23021, 0.68414, -0.08523, 0.054161, 0.80214, 0.20656, -0.32227, 0.37844, 0.20627,
    -1.0774, -0.61334, -0.73487, -0.28478, 1.0191, -0.22138, -0.73171, -0.28474, -0.34535, 0.62541, -0.36809, 1.2592, 0.82127, -0.009812, -0.054254,
    -0.84266, 0.5717, -0.97247, -0.087159, 0.33116, 0.064052, 0.03391, -0.29007, 0.46302, -1.1375, 0.82586, -0.39826, 0.16527, 0.22807, 0.38195,
    0.44168, 0.57781, 0.034197, -0.748, 0.11892, 0.16351, 0.42354, -0.28662, -0.26196, -0.10248, 0.85427, -0.95801, -0.9252, -0.69066, 0.24729,
    -0.71803, 0.30294, 0.076059, -1.0195, 0.27025, 0.81747, 0.056543, 0.7067, -0.34217, -0.14514, -0.64456, -0.40566, 0.97792, -0.45515, 0.10869,
    -0.14503, -0.11104, -0.19103, -1.9016, -0.71862, -0.74646, 0.060762, 0.11829, -0.64198, -1.0602, 0.82768, -1.5281, 0.7939, 0.90642, 0.36591,
    -1.1602, 0.55613, 0.55064, 0.39422, 0.27466, 0.11219, 0.082657, -1.066, 0.45729, 0.21349, -0.65992, -0.029698, -0.15071, -0.10348, 0.34604,
    -0.88439, 0.93222, -0.27268, 0.75309, 0.82531, 0.32583, -0.12306, -0.37259, -0.19254, -0.21685, -1.0945, 0.31233, 0.83378, -0.89195, 0.84415,
    0.41855, -0.6136, -0.62079, 0.59303, -0.60958, 0.062238, -0.2066, -0.18143, 0.077936, 0.68933, -1.0756, 0.54917, 0.63022, -0.2394, -0.22939,
    0.66357, -0.29729, 0.52122, 0.26289, -0.053064, 0.28174, 0.74691, 0.64433, 0.10488, -0.68213, -0.53041, -0.98897, -0.43222, -1.1328, 0.1872,
    -0.42062, 0.8704, 0.17308, -0.54679, 0.45603, 0.85255, -0.39394, -0.79087, 0.37149, -0.30914, 0.42699, -0.4614, 1.2606, -0.19173, 0.28541,
    0.21655, 0.46685, 0.3814, -0.20287, -0.65877, -0.27152, 0.51924, -1.2188, 0.099208, 0.033332, 0.64179, -0.6249, -1.1168, -0.078329, 0.7107;

    lw2 << 0.13741, 0.59882, -0.23679, 1.3075, 0.94737, -0.47618, -0.023854, -0.68865, 0.19933, -0.51375, -0.60764, 0.30309, -0.019793, 0.38687, -0.14405,
    0.076684, 0.55087, -0.2359, 0.5455, -0.17747, -0.53209, -0.50195, 0.62151, 0.85924, -0.15895, -0.60057, 0.58453, 0.35756, -0.5843, 0.65933,
    0.20522, -0.48261, -0.084119, 0.13142, -0.89191, 0.47839, 0.72246, -0.782, 0.4434, -0.095685, 0.55488, 0.47627, -0.59689, -0.44329, -1.722,
   -0.11659, -0.46753, 1.6093, 0.049151, -0.69477, 0.75154, -0.52211, 0.61348, -0.80557, 0.63141, 0.79739, 0.45441, 0.88529, -0.42896, -0.34,
    0.34999, -0.49043, -0.12585, -0.26987, -0.13183, -0.10949, 0.13472, 0.17052, 0.35156, 0.077545, 0.73782, -0.93105, -0.042422, 0.66625, -0.48424,
    0.26062, 0.65252, -0.59297, 0.20285, -0.3117, 0.68083, -0.38497, 0.1941, 0.54899, 0.15378, -0.32339, 0.75756, 0.56665, -0.81699, 0.38105,
    0.2117, 0.34173, 0.54454, -1.0192, -0.87112, -0.92424, -0.53138, -0.34427, -0.52582, -0.54309, 0.50521, -0.88807, -0.20913, 0.4381, 0.60278,
    -0.18684, -0.40584, -0.99645, -0., -0.33841, 0.57265, -0.61432, -0.079443, -0.99862, 0.90374, -0.30693, -0.69134, -0.47551, -0.47243, 0.40535,
    0.32926, 0.16944, 0.20228, 0.16021, 0.05517, 0.67373, -0.83464, 0.24824, 0.93484, -0.034042, -0.64662, 0.93311, 0.26962, -0.55707, 0.11306,
    -0.50463, 0.036628, 0.15689, -0.27157, 1.0628, -0.16074, 0.78898, 0.56283, 0.065189, 0.34186, 0.58843, -0.35055, 0.59214, 0.60049, 1.2078,
    0.019568, 0.27803, -0.46292, -0.099799, -0.36431, 0.52111, -0.10977, 0.39075, -0.029661, 0.42734, -0.67814, 0.38993, 0.58264, -0.40667, 0.060159,
    0.037527, -0.62309, -0.30042, 0.021017, -0.074473, 0.34596, -0.13892, 0.60155, 0.44064, 0.87822, -0.41047, 0.17952, -0.29146, -0.50332, 0.26531,
    -0.29598, 0.86346, -0.93312, 0.35882, -0.30762, -0.31269, -0.025333, 0.24964, 0.020314, 0.45007, 0.43979, 0.80562, -0.42056, 0.77657, -0.36312,
    -0.19083, 0.10788, 0.66119, 0.06987, 0.39679, 0.12157, 0.30587, -0.67193, -0.51985, -0.57139, -0.03858, 0.60517, 0.4408, 0.20806, -0.14087,
    0.6568, -0.075942, -0.056323, -0.55089, -0.54704, 0.13956, -0.84508, 0.50128, 0.020664, 0.4199, -0.65651, 0.43938, 0.59447, -0.95747, -0.33031;

    lw3 << 0.59909,-0.13488,0.039766,0.45555,0.17968,1.4665,-0.84424,-0.63318,-1.089,0.49058,0.51023,0.85285,0.39044,0.47806,-0.15919,
            -0.079901,0.41627,-0.42561,-0.62711,-1.3129,-0.97605,0.65405,0.74947,-0.39468,-0.17221,-0.3052,-0.33534,0.58236,0.17403,0.4305,
            -0.20774,-0.77002,0.36356,0.02132,0.52408,0.35562,1.0686,0.16407,-0.43089,0.30785,-0.40335,0.75659,-0.82545,-0.048205,0.78985,
            -0.26813,0.22927,-0.36854,-0.34999,-0.22728,0.28072,0.67294,0.099855,-0.17794,-0.13425,-1.2635,-1.2279,0.020895,-1.4042,0.86721,
            -0.38742,-0.041112,-0.66051,-0.48196,0.010362,0.59089,-0.10039,-0.23917,-0.068478,0.078153,0.70972,-0.975,0.37155,-0.23779,-0.83409,
            -0.65926,0.34008,1.4464,0.45735,-0.065829,0.074214,0.61386,-0.15884,0.65649,0.42375,0.61801,0.83425,-0.10446,0.52228,-0.45817,
            -0.34121,0.006074,-0.25357,-0.236,0.45753,0.91191,0.74534,-0.68381,-0.61127,-1.202,-0.5788,-0.38141,-0.38338,0.49994,-0.31935,
            0.15419,-0.60948,-0.0080493,-0.59698,0.99834,0.22146,0.26499,-0.3233,-0.75371,-1.0246,0.75162,0.0050493,0.27896,-0.071539,-0.64503,
            -1.0724,-1.1138,0.20373,-0.098966,0.19457,0.911,-0.73658,-0.13474,-0.26908,-0.48889,0.31966,-0.31561,0.042437,-0.41314,-1.2963,
            0.13192,-0.8119,0.2449,-1.0908,0.012649,0.42186,0.44324,0.78626,0.011356,0.37529,-0.019459,-0.58422,0.45297,0.24563,0.47775,
            -0.92119,0.43751,0.53324,-0.69,0.83037,-0.38621,-0.62003,-0.32921,-0.19088,-0.23776,-0.042406,-0.90448,-0.02624,-0.44171,-0.89272,
            -0.28939,-0.095199,-0.73735,-0.2022,1.1589,0.4335,0.07309,0.23905,0.37997,-0.047704,-0.73818,-0.056959,-0.0075534,0.63253,-0.16218,
            -0.074649,-0.14543,-0.42491,0.40639,-0.94068,-0.087402,-0.55872,-0.32341,-0.0078636,-0.87541,-0.94777,0.5482,0.4547,-0.23797,-0.64675,
            1.326,0.69431,0.4322,0.21433,0.057168,0.18319,0.15961,0.80647,0.27441,0.37742,0.18146,1.5872,-0.25001,0.096603,0.095676,
            0.45971,0.73055,1.3086,-0.31798,-0.25925,-0.74791,0.41752,-0.20811,-0.085891,0.13472,0.44439,0.40625,-0.23134,0.49581,-0.51785;


    lw4 << -0.024415,0.05768,0.91315,0.39486,0.33391,0.49212,0.9039,0.45981,0.34831,0.89925,0.46663,0.18732,-0.13231,-0.46103,-0.027602,
            0.88691,0.054984,0.68398,0.4594,-0.45047,0.86583,-0.059012,0.029538,-0.81288,-0.29459,0.40674,0.34769,0.71823,0.70433,-0.23943,
            -0.17239,0.65246,-0.83188,0.28897,0.78912,0.47675,0.10607,-0.80297,0.31461,0.25003,-0.91809,-0.11786,0.14165,-0.20675,0.54593,
            0.31943,0.66919,0.55205,-0.30617,-0.69752,1.1513,-0.15159,-0.63821,-0.47301,-0.64838,0.58233,0.21043,-0.062428,-1.3869,-0.69871,
            -0.36907,-0.71213,-0.25241,0.97758,0.58259,0.45062,-0.30614,0.95735,-0.59617,0.82679,-0.4328,1.2157,-0.47166,1.399,0.52905,
            -0.0062047,-0.22967,0.24463,0.10105,-0.83034,-0.25542,0.88204,-0.026772,0.64758,0.70912,-0.20025,1.0366,0.79675,0.45116,-0.32478,
            -0.21799,-0.50497,-0.56085,-1.0876,-0.63695,-0.83372,0.285,-0.86444,0.6585,0.14762,0.90321,-1.4432,-0.69963,-0.57327,-0.15947,
            -0.14585,0.15912,0.094885,1.0817,0.14214,-0.23912,1.3423,-0.10027,0.34369,0.26421,-0.14776,-0.65872,0.97314,0.15805,-0.82447,
            0.32962,-0.024268,-0.30377,0.16262,-0.36762,-0.27434,1.066,0.69202,-0.67736,-0.14306,-0.26056,-0.50857,-1.0595,-0.29595,-0.42186,
            0.90056,-0.19177,-0.30654,1.0875,-0.60919,-0.87619,1.057,0.23995,-0.77562,-0.77756,-0.11784,-0.41332,-0.50736,-0.14246,-0.19328,
            0.67697,-0.2005,-0.38515,-0.052957,-0.89258,0.34757,0.65477,0.34166,1.0644,0.40722,-0.76085,1.3037,-0.37711,0.076794,-0.7316,
            -0.444,0.46214,-0.14775,1.1095,-0.29335,-0.078122,-0.39664,0.075268,0.79203,-0.94083,-0.32711,-1.1247,-1.052,-0.36922,0.39501,
            -0.88317,-0.11929,0.48908,-0.75411,-0.49531,0.33928,-0.42314,0.19355,0.55668,-0.76119,-1.0237,-0.47715,-0.40629,-0.002319,0.18979,
            -0.094244,0.43876,0.44985,1.2752,-0.71487,-0.80102,0.60546,0.2733,0.31222,-0.22219,0.38521,0.81112,-0.68145,0.50669,-0.35828,
            -0.58486,-0.11783,0.74589,0.97901,-0.29753,0.35806,-0.2673,0.81286,0.49366,-0.63382,-0.79285,0.88305,-0.16365,0.58061,-0.16694;


    lw5 << 0.030307,-0.6097,-0.71073,0.27195,-0.085601,-0.15617,0.73967,-0.46306,-0.46136,0.63683,0.03236,0.72215,1.0519,0.5405,0.43102,
            -0.47801,-0.071199,0.28212,-0.07947,-0.32474,-0.95589,0.48189,-0.6293,-0.14357,0.27158,-0.3,1.194,0.40775,-0.16892,-0.37762,
            -0.42069,-0.41824,0.54099,0.33257,0.87006,-0.47856,0.039106,-0.59219,0.3302,0.038943,0.90994,0.83695,0.96532,0.10616,0.96425,
            -0.20417,-0.43206,-0.64792,0.54715,0.03437,0.061608,0.87031,0.92581,-0.34621,0.090856,-1.1407,-0.59982,-0.94328,0.23954,1.2427,
            0.59882,0.21132,0.68933,-0.32358,0.74265,-0.89461,0.6462,-0.58543,1.2647,-0.12223,0.59984,-0.079223,0.28554,-0.34742,0.30886,
            -0.67149,0.038626,1.1639,0.27259,-0.059221,0.20969,0.23736,-0.14037,-1.4043,0.39659,0.71864,0.66443,0.40996,1.0963,-0.82139,
            0.70354,-0.50526,-0.34829,-1.0454,0.36364,-0.065792,-0.14867,-0.69,0.57362,0.076331,-0.48232,0.56627,-0.074511,-1.0841,1.1941,
            -0.035805,-0.28764,-0.70709,-0.10235,0.17835,-1.4927,0.57714,0.36483,0.93501,-0.25056,0.7299,0.13298,0.41,1.1002,-0.35092,
            0.58863,0.035524,0.72987,0.54716,-0.23681,-1.148,-1.4847,-0.12828,0.35723,-0.12265,0.09211,-0.15364,0.84562,0.54165,-0.32593,
            0.17037,-0.78698,0.54789,0.18209,0.54962,1.2577,0.17409,0.62038,0.30937,0.34123,-0.17946,-0.052728,-0.31166,-0.14044,-1.2015,
            0.60883,0.8074,0.31993,-0.30999,-0.60691,0.22441,0.047265,-0.13721,-0.25055,0.65619,-0.72873,1.1597,-0.19649,-0.17769,-0.93579,
            -0.47622,0.37454,0.23478,-0.43099,0.12193,0.44358,-0.45688,0.63833,0.90122,0.7543,0.70647,-0.30251,-0.015588,-0.65727,-1.0316,
            -0.3542,0.15307,-0.60876,-0.91875,1.384,0.94745,-0.54679,0.5384,0.016914,-1.1256,0.57644,-0.61836,-0.8212,-0.71905,-0.54374,
            0.9002,0.66978,-0.11378,-0.28758,-0.087982,-0.68698,-0.87765,0.28719,0.21326,-0.1245,-0.62731,0.56903,0.38367,-0.1795,-0.27469,
            -0.82718,-1.7283,-0.36576,0.066933,0.040317,0.78937,-0.7856,0.050934,-0.15925,-0.12538,0.99949,-0.28029,0.54236,0.65524,0.83421;


    lw6 << 0.64082,0.0093524,-0.06457,-0.4491,0.0087192,-0.42719,-0.59943,-0.15157,0.67126,-0.025821,-0.49931,-0.33734,0.69255,0.21959,0.53763,
            -0.76982,0.50421,-0.18446,-0.29169,0.16217,0.37888,-0.4955,0.77539,-0.2713,0.79257,-0.07949,0.50526,0.54921,0.24973,0.94166,
            0.47968,-0.38347,0.21555,-0.6258,-0.33059,0.50438,-0.53744,-0.23741,0.5528,-0.65396,-0.55399,0.47284,0.46339,-0.42283,0.050192,
            0.29676,-0.78009,0.57495,0.12991,0.46187,-1.5767,0.42801,0.29465,-0.32807,-1.4112,-1.0229,-0.20984,0.50515,0.29214,-0.0032603,
            -0.31729,0.57371,0.737,0.98621,-0.82052,1.0584,-0.2323,1.0564,-0.30495,0.50362,-1.0282,0.35328,-1.3139,-0.20175,0.42149,
            0.07855,0.47736,0.80173,-0.3678,-0.017869,-0.12851,0.5865,0.78896,-0.51335,0.47783,0.46761,0.31385,-0.15024,0.21006,-0.99177,
            -1.0357,0.074968,-0.080944,0.17253,-0.74572,-0.86043,0.49475,0.29089,-0.22463,-0.79486,1.0884,0.60062,-0.02949,0.65687,-1.1619,
            -0.79905,0.29018,-0.018132,-0.083586,0.48707,-0.022609,0.77967,-0.10936,-0.50198,0.48897,-0.019646,0.29836,0.59505,-0.0095504,-0.5616,
            -0.15513,-0.27419,-0.15929,0.9958,0.5185,-0.2523,0.12308,0.73261,-0.52983,0.31304,-0.94747,-0.39099,-0.0099278,0.70341,-0.25081,
            0.15932,0.42231,1.1889,-0.51392,-1.1255,-0.46426,-0.70125,0.53908,1.2267,-0.15453,0.60088,-0.77683,0.049991,0.085454,0.43638,
            0.3402,-0.41401,0.20384,0.50423,1.3848,-0.054666,-0.90942,0.036558,-0.32878,-0.57169,-0.046263,-0.10411,1.3483,-0.51306,0.2503,
            -0.66906,-0.91801,1.0403,0.44691,0.0043169,0.88046,0.83768,-0.93047,0.90852,0.4624,-1.1713,-0.093215,-0.4431,0.22218,-0.4304,
            -0.57333,0.27284,0.42514,-0.80217,-0.26105,0.87796,-0.95612,-0.35019,-0.92223,-0.14398,-0.63841,0.037699,-1.206,-0.22948,0.080865,
            0.77479,0.23451,-1.4273,1.6226,0.18947,0.2139,0.78344,-0.63061,0.24653,0.19753,-0.13382,0.12853,-0.43193,-0.44148,0.16818,
            -0.40199,0.18668,-0.79611,0.004453,0.36192,0.66783,-0.56941,-0.96817,-0.68751,-0.21596,0.066186,-0.24582,0.13305,-0.12034,-0.071343;
;

    lw7 << -0.6973, -1.2268, -0.62766, 1.4876, 1.954, -0.17127, 0.87015, -0.93006, 1.8047, -2.8451, -2.5471, -0.83114, 2.0565, 1.6818, -0.40064;


    b1 << -2.5805,
    -1.1944,
    2.6144,
    2.3791,
    1.0649,
    -0.81351,
    -0.28732,
    0.16938,
    -0.012964,
    -0.72654,
    -1.2508,
    -1.8171,
    -1.8055,
    -1.7005,
    -3.2554;

    b2 << -1.7588,
    1.8937,
    0.80197,
    0.75256,
    0.46402,
    0.3129,
    -0.10717,
    0.065805,
    -0.22183,
    -0.88351,
    -0.7659,
    0.69583,
    1.1747,
    1.7824,
    -1.5717;

    b3 << 1.3612,
    -1.5157,
    0.98144,
    0.80898,
    -0.51094,
    -0.58999,
    0.035164,
    -0.10062,
    0.44117,
    -0.54253,
    -0.54127,
    0.76597,
    -1.3916,
    -1.8421,
    1.3959;

    b4 << 1.2435,
    -1.7306,
    1.2903,
    -1.1342,
    0.78992,
    0.21209,
    0.97841,
    -0.22839,
    -0.12178,
    -0.0623,
    -0.17031,
    1.2363,
    -1.2026,
    1.3136,
    1.5971;

    b5 << -1.6018,
    -1.1547,
    -0.7031,
    -1.2379,
    1.2582,
    0.41843,
    -0.47672,
    0.35597,
    0.014522,
    0.3483,
    0.41551,
    -0.71413,
    -1.4031,
    -1.1434,
    -1.5634;

    b6 << -1.6855,
    1.3839,
    1.3522,
    0.82298,
    -0.88871,
    1.0397,
    -0.58925,
    -0.000063009,
    0.05056,
    0.39284,
    0.25566,
    -0.81172,
    -1.0973,
    1.5789,
    -1.747;

    b7 << -1.6509,
    1.5934,
    -1.2005,
    -1.0453,
    0.67188,
    -0.33639,
    0.11418,
    0.078781,
    -0.67552,
    -0.6482,
    1.1439,
    -1.1082,
    -0.70082,
    -1.5036,
    -1.6365;

    b8 << -0.74173;

    //QList<double> etp_value;
    MatrixXd i1(3,1);
    MatrixXd tmp(15,1);
    MatrixXd tmp2(15,1);

    //i1 << 0, 0, 0, 0, 0, 0, 0, 0, 1, latitude/18.25, longitude/105.75;
    //i1 << 0, 0, 0, 0, 0, 0, 0, 0, 1, 0.111, 0.777;
    //qDebug() << "ETp input lat->" + QString::number(i1(9,0)) + " long->" + QString::number(i1(10,0));

    m_ETp.clear();
    for(int day=1;day<=365;day++)
    {
        // convert day to binary
        //int buff[9] = {0,0,0,0,0,0,0,0,0};
        //int num = day;
        //for(int digit=1;digit<=9;digit++)
        //{
        //    buff[9-digit] = num%2;
        //    num/=2;
        //}
        //for(int i=1;i<=9;i++)
        //{
        //    i1(i-1,0) = buff[i-1]*2-1;
            //i1(i-1,0) = buff[i-1];
        //}
        /*************************************
         * lat  = (14.25,18.25), range = 4.0
         * long = (101.25,105.75), range = 4.5
         *
         *************************************/
        //i1(9,0) = (m_latitude.toDouble()*2/18.25)-1;
        //i1(10,0) = (m_longitude.toDouble()*2/105.75)-1;
        //i1(9,0) = (m_latitude.toDouble()/18.25);
        //i1(10,0) = (m_longitude.toDouble()/105.75);
        //i1(9,0) = (m_latitude.toFloat()-14.25)*0.777*2.574/4.0 - 1;
        //i1(10,0) = (m_longitude.toFloat()-101.25)*0.777*2.574/4.5 - 1;
        float buff1 = (day-1)*0.00549 - 1;
        i1(0,0) = buff1;
        buff1 = (m_latitude.toFloat()-14.25)*0.777/4.0;
        i1(1,0) = buff1*2.574 - 1;
        buff1 = (m_longitude.toFloat()-101.25)*0.777/4.5;
        i1(2,0) = buff1*2.574 -1;

        tmp = iw*i1 + b1;
        for(int i=0;i<15;i++)
        {
         tmp(i,0) = 2/(1+exp(-2*tmp(i,0)))-1;
         //qDebug() << "First layer [" + QString::number(i) + "] -> " + QString::number(tmp(i,0));
        }
        //l2w = l2w.transposeInPlace();
        tmp2 = lw1*tmp + b2;
        //tmp = tmp2;
        for(int i=0;i<15;i++)
        {
         tmp(i,0) = 2/(1+exp(-2*tmp2(i,0)))-1;
         //qDebug() << "First layer [" + QString::number(i) + "] -> " + QString::number(tmp(i,0));
        }
        //l3w = l3w.transposeInPlace();
        tmp2 = lw2*tmp + b3;
        //tmp = tmp2;
        for(int i=0;i<15;i++)
        {
         tmp(i,0) = 2/(1+exp(-2*tmp2(i,0)))-1;
         //qDebug() << "First layer [" + QString::number(i) + "] -> " + QString::number(tmp(i,0));
        }
        //l4w = l4w.transposeInPlace();
        tmp2 = lw3*tmp + b4;
        //tmp = tmp2;
        for(int i=0;i<15;i++)
        {
         tmp(i,0) = 2/(1+exp(-2*tmp2(i,0)))-1;
         //qDebug() << "First layer [" + QString::number(i) + "] -> " + QString::number(tmp(i,0));
        }
        //l5w = l5w.transposeInPlace();
        tmp2 = lw4*tmp + b5;
        //tmp = tmp2;
        for(int i=0;i<15;i++)
        {
         tmp(i,0) = 2/(1+exp(-2*tmp2(i,0)))-1;
         //qDebug() << "First layer [" + QString::number(i) + "] -> " + QString::number(tmp(i,0));
        }
        //l6w = l6w.transposeInPlace();
        tmp2 = lw5*tmp + b6;
        //tmp = tmp2;
        for(int i=0;i<15;i++)
        {
         tmp(i,0) = 2/(1+exp(-2*tmp2(i,0)))-1;
         //qDebug() << "First layer [" + QString::number(i) + "] -> " + QString::number(tmp(i,0));
        }
        //l7w = l7w.transposeInPlace();
        tmp2 = lw6*tmp + b7;
        //tmp = tmp2;
        for(int i=0;i<15;i++)
        {
         tmp(i,0) = 2/(1+exp(-2*tmp2(i,0)))-1;
         //qDebug() << "First layer [" + QString::number(i) + "] -> " + QString::number(tmp(i,0));
        }

        MatrixXd tmp3(1,1);
        tmp3 = lw7*tmp + b8;
        double out = 5.56*(((tmp3(0,0)+1)*0.5144/2)+0.4856);

        //double out = tmp3(0,0);
        m_ETp.append( out );
        //qDebug() << "ETp value of day: " + QString::number(day) + " from ANN: " + QString::number(m_ETp.last());
    }
    // for day 366
    m_ETp.append(m_ETp.last());
    //qDebug() << "ETp value of day: 366 from ANN: " + QString::number(m_ETp.last());

}


/*
void AppData::computeETp()
{
    fann_type *calc_out;
    fann_type input[11];
    struct fann *ann = fann_create_from_file("../ETpTraining/ETp_float.net");
    m_ETp.clear();
    for(int day=1;day<=365;day++)
    {
        // convert day to binary
        int buff[9] = {0,0,0,0,0,0,0,0,0};
        int num = day;
        for(int digit=1;digit<=9;digit++)
        {
            buff[9-digit] = num%2;
            num/=2;
        }
        for(int i=1;i<=9;i++)
        {
            input[i-1] = buff[i-1];
            //i1(i-1,0) = buff[i-1];
        }
        //input[9] = m_latitude.toFloat()/18.25;
        //input[10] = m_longitude.toFloat()/105.75;
        input[9] = 0;
        input[10] = 0.777;

        //input[0] = day;
        //input[1] = m_latitude.toFloat()/18.25;
        //input[2] = m_longitude.toFloat()/105.75;
        //input[1] = 0.0;
        //input[2] = 0.777;

        calc_out = fann_run(ann, input);
        m_ETp.append(calc_out[0]*5.56);
        qDebug() << "Estimated ETp[" + QString::number(day) + "] = " + QString::number(m_ETp.last());
    }
    // for day 366
    m_ETp.append(m_ETp.last());
    fann_destroy(ann);
} */

double AppData::getETp(int index)
{
    return m_ETp.at(index);
}

void AppData::readETp()
{
    QSqlQuery qry;
    m_ETp.clear();
    qry.prepare("BEGIN TRANSACTION");
    qry.exec();
    if (qry.prepare("SELECT * FROM ETp WHERE Id=:Id"))
    //if (qry.prepare("SELECT * FROM ETp WHERE Id>='0' AND Id<='365'"))
    {
      for(int i=0;i<366;i++)
        {
          qry.bindValue(":Id", i+1);

          if (qry.exec())
          {
              while(qry.next())
              {
                  m_ETp.append(qry.value(qry.record().indexOf("ETp")).toDouble());
                  //qDebug() << "ETp -> " + QString::number(m_ETp.last());
              }
          }
          else
            qDebug() << "AppData:: Read ETp failed!";
        }
      qry.prepare("COMMIT");
      qry.exec();
      qDebug() << "Read ETP successfully...!";
    }
    else
      qDebug() << "AppData:: Read ETp query broken!";
}

void AppData::resetPumpTime()
{
    m_pumpOnMS = 0;
}

void AppData::pausePumpTime()
{

}

void AppData::startPumpTime()
{
    m_pumpOnTime.start();
}

void AppData::stopPumpTime()
{
    m_pumpOnTime = QTime(0,0,0,0);
}

QString AppData::getPumpTimeElapse()
{
    QString t;
    m_pumpOnMS = m_pumpOnTime.elapsed();
    int secs = m_pumpOnMS / 1000;
    int mins = (secs / 60) % 60;
    int hours = (secs / 3600);
    secs = secs % 60;
    //qDebug() << "Pump on time elapse = " + QString::number(m_pumpOnTime.elapsed()) + " ms...";
    //t = ""+QString::number(hours)+":"+QString::number(mins)+":"+QString::number(secs);
    return t.sprintf("%02d:%02d:%02d",hours,mins,secs);
}

void AppData::resetValve1Time()
{
    m_valve1OnMS = 0;
}

void AppData::pauseValve1Time()
{

}

void AppData::startValve1Time()
{
    m_valve1OnTime.start();
}

void AppData::stopValve1Time()
{
    m_valve1OnTime = QTime(0,0,0,0);
}

QString AppData::getValve1TimeElapse()
{
    QString t;
    m_valve1OnMS = m_valve1OnTime.elapsed();
    int secs = m_valve1OnMS / 1000;
    int mins = (secs / 60) % 60;
    int hours = (secs / 3600);
    secs = secs % 60;
    //qDebug() << "Pump on time elapse = " + QString::number(m_pumpOnTime.elapsed()) + " ms...";
    //t = ""+QString::number(hours)+":"+QString::number(mins)+":"+QString::number(secs);
    return t.sprintf("%02d:%02d:%02d",hours,mins,secs);
}

void AppData::resetValve2Time()
{
    m_valve2OnMS = 0;
}

void AppData::pauseValve2Time()
{

}

void AppData::startValve2Time()
{
    m_valve2OnTime.start();
}

void AppData::stopValve2Time()
{
    m_valve2OnTime = QTime(0,0,0,0);
}

QString AppData::getValve2TimeElapse()
{
    QString t;
    m_valve2OnMS = m_valve2OnTime.elapsed();
    int secs = m_valve2OnMS / 1000;
    int mins = (secs / 60) % 60;
    int hours = (secs / 3600);
    secs = secs % 60;
    //qDebug() << "Pump on time elapse = " + QString::number(m_pumpOnTime.elapsed()) + " ms...";
    //t = ""+QString::number(hours)+":"+QString::number(mins)+":"+QString::number(secs);
    return t.sprintf("%02d:%02d:%02d",hours,mins,secs);
}

void AppData::KeepScreenOn(bool on) {
    static const int FLAG_KEEP_SCREEN_ON = QAndroidJniObject::getStaticField<jint>("android/view/WindowManager$LayoutParams","FLAG_KEEP_SCREEN_ON");

    QtAndroid::runOnAndroidThread([on, FLAG_KEEP_SCREEN_ON] {
        auto window = QtAndroid::androidActivity().callObjectMethod("getWindow","()Landroid/view/Window;");
    if (on)
    {
        window.callMethod<void>("addFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
        qDebug() << "Keep screen on...!";
    }
    else
    {
        window.callMethod<void>("clearFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
        qDebug() << "Keep screen off...!";
    }
 });
}
