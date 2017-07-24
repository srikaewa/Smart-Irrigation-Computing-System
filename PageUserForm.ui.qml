import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.1
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
//import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0



Item {
    id: itemUser
    width: 480
    height: 800
    property alias buttonSignIn: buttonSignIn
    property alias buttonSignUp: buttonSignUp
    property alias labelUserLoginStatus: labelUserLoginStatus
    property alias busyIndicatorUserLogin: busyIndicatorUserLogin
    property alias textFieldEmail: textFieldEmail
    property alias textFieldPassword: textFieldPassword
    property alias textFieldFirstName: textFieldFirstName
    property alias textFieldLastName: textFieldLastName
    property alias textFieldOrganization: textFieldOrganization
    property alias buttonRememberSignIn: buttonRememberSignIn

    Settings{
        property alias rememberSignedIn: buttonRememberSignIn.checked
        property alias userEmail: textFieldEmail.text
        property alias userPassword: textFieldPassword.text
        property alias userFirstName: textFieldFirstName.text
        property alias userLastName: textFieldLastName.text
        property alias userOrganization: textFieldOrganization.text
    }

    Flickable{
        id: flickableUserForm
        width: parent.width
        height: parent.height
        flickableDirection: Flickable.VerticalFlick
        contentHeight: columnWrapper.height * 1.2
        ColumnLayout{
            id: columnWrapper
            spacing: 20
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.verticalCenter: parent.verticalCenter
            anchors{
                horizontalCenter: parent.horizontalCenter
            }

            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label {
                    id: label
                    text: qsTr("\nSMART IRRIGATION COMPUTING SYSTEM\n")
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.035)
                    font.bold: true
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label{
                    text: "First Name "
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    font.bold: true
                }

                TextField {
                    id: textFieldFirstName
                    height: 40
                    text: ""
                    placeholderText: "กรอกชื่อที่นี่..."
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    Layout.minimumWidth: 300
                }

            }
            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label{
                    text: "Last Name "
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    font.bold: true
                }

                TextField {
                    id: textFieldLastName
                    height: 40
                    text: qsTr("")
                    placeholderText: "กรอกนามสกุลที่นี่..."
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    Layout.minimumWidth: 300
                }

            }
            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label{
                    text: "Organization "
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    font.bold: true
                }

                TextField {
                    id: textFieldOrganization
                    height: 40
                    text: qsTr("")
                    placeholderText: "กรอกชื่อหน่วยงานที่นี่..."
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    Layout.minimumWidth: 300
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label{
                    text: "Username "
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    font.bold: true
                }

                TextField {
                    id: textFieldEmail
                    height: 40
                    text: qsTr("")
                    placeholderText: "กรอกอีเมล์ที่นี่..."
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    Layout.minimumWidth: 300
                }

            }

            RowLayout{
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label{
                    text: "Password "
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    font.bold: true
                }

                TextField {
                    id: textFieldPassword
                    width: 400
                    height: 40
                    text: qsTr("")
                    placeholderText: "กรอกรหัสผ่านที่นี่..."
                    echoMode: TextInput.Password
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    Layout.minimumWidth: 300
                }
            }

            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                Button {
                    id: buttonSignIn
                    width: 134
                    height: 40
                    text: "Sign In"
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    flat: true
                }

                Label{
                    text: "       "
                }

                Button {
                    id: buttonSignUp
                    width: 134
                    height: 40
                    text: "Sign Up"
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    flat: true
                }

                Label{
                    text: "       "
                }
                Button{
                    id: buttonRememberSignIn
                    width: 134
                    height: 40
                    text: "Remember me"
                    font.family: fontRegular.name
                    font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                    flat: true
                    checkable: true
                    checked: false
                    enabled: false
                }
            }

            Label {
                id: labelUserLoginStatus
                text: "Please sign in to begin using app..."
                font.family: fontRegular.name
                font.italic: true;
                font.pixelSize: (Screen.primaryOrientation == Qt.LandscapeOrientation ? flickableUserForm.height * 0.04 : flickableUserForm.height * 0.02)
                Layout.alignment: Qt.AlignHCenter
            }

            Label{
                text: "\n\n"
            }

            Row{
                Layout.alignment: Qt.AlignHCenter
                anchors.top: labelUserLoginStatus.bottom
                anchors.topMargin: 30
                Image {
                    id: image
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/NRCT2.png"
                }

                Image {
                    id: image1
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/nstda.png"
                }

                Image {
                    id: image2
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/sut_logo.png"
                }

                Image {
                    id: image3
                    width: 68
                    height: 85
                    fillMode: Image.PreserveAspectFit
                    source: "images/SunTrust_AI_Logo.png"
                }
            }
        }
    }

    BusyIndicator {
        id: busyIndicatorUserLogin
        width: parent.height / 8
        height: parent.height / 8
        anchors.centerIn: parent
        running: false
        //visible: false
    }
}
