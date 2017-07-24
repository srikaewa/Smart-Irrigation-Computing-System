#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QPointF>
#include <QChartView>
#include <QSplashScreen>
//#include <QDesktopWidget>
//#include <QtWebEngine/QtWebEngine>
//#include <QtWebView/QtWebView>

#include <appdata.h>
#include <deviceinfo.h>
#include <firebaseobject.h>

#ifdef Q_OS_ANDROID
# include <QtAndroid>
#endif

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    //QPixmap pixmap(":/images/Splash_Screen.png");

/*    if (pixmap.isNull())
    {
        pixmap = QPixmap(300, 300);
        pixmap.fill(Qt::magenta);
    } */

    //QSplashScreen *splash = new QSplashScreen(pixmap);
    //splash->show();
    //qApp->processEvents(QEventLoop::AllEvents);
    //splash->showMessage("Loading irrigation database...",Qt::AlignBottom | Qt::AlignCenter, Qt::black);
    //qApp->processEvents(QEventLoop::AllEvents);

    //QtWebView::initialize();
    QQuickStyle::setStyle("Material");
    //QtWebEngine::initialize();

    /**** register AppData class ****/
    qmlRegisterType<AppData>("AppData", 1, 0, "AppData");
    /*********************************/

    /**** register DeviceInfo class ****/
    qmlRegisterType<DeviceInfo>("DeviceInfo", 1, 0, "DeviceInfo");
    /*********************************/

    /**** register FirebaseObject class ****/
    qmlRegisterType<FirebaseObject>("FirebaseObject", 1, 0, "FirebaseObject");
    /*********************************/

	QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    //engine.addImportPath(QStringLiteral("jbQuick/Charts"));
	engine.addImportPath(QStringLiteral("qml"));

    #ifdef Q_OS_ANDROID
        QtAndroid::hideSplashScreen();
    #endif
    //splash->finish(&engine);
    //delete splash;
    return app.exec();
}
