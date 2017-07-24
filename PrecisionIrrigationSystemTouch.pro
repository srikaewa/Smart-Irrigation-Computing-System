QT += core qml quick quickcontrols2 charts sql gui widgets location
QT += network gui-private androidextras
CONFIG += c++11

SOURCES += main.cpp \
    appdata.cpp \
    deviceinfo.cpp \
    firebaseobject.cpp \
    userlogin.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code  model
#QML_IMPORT_PATH += qml/jbQuick/Charts

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    appdata.h \
    deviceinfo.h \
    firebaseobject.h \
    userlogin.h

DISTFILES += \
    PushTapeLength.qml \
    PushDripInterval.qml \
    qtquickcontrols2.conf \
    PushTapeNumber.qml \
    PushDripFlowRate.qml \
    PushTapeInterval.qml \
    android-sources/AndroidManifest.xml \
    android-sources/gradle/wrapper/gradle-wrapper.jar \
    android-sources/gradlew \
    android-sources/res/values/libs.xml \
    android-sources/build.gradle \
    android-sources/gradle/wrapper/gradle-wrapper.properties \
    android-sources/gradlew.bat \
    PageSensorInfoForm.ui.qml \
    PageSensorInfo.qml \
    images/suntrust_ai_landscape.png \
    images/suntrust_ai_portrait.png \
    images/Splash_Screen.png \
    google-services.json \
    PageUserForm.ui.qml \
    PageUser.qml

deployment.files += cws2.sqlite\
                    ETp_float.net \
                    google-services.json

deployment.path = /assets
INSTALLS += deployment

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources

# add static openssl library as Android 6.0+ do not support openssl anymore
contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        $$PWD/../openssl-1.0.2k/libcrypto.so \
        $$PWD/../openssl-1.0.2k/libssl.so
}

LIBS += -L$$PWD/../firebase_cpp_sdk/libs/android/armeabi-v7a/c++/ -lauth
LIBS += -L$$PWD/../firebase_cpp_sdk/libs/android/armeabi-v7a/c++/ -lapp

