import QtQuick 2.12
import QtQuick.Window 2.12
import MyLanguage 1.0
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    Rectangle{
        width: 100
        height: 100
        color: "lightsteelblue"
        Text{
            text: qsTr("Monday") + mytrans.emptySting
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                mytrans.updateLanguage(MyLanguage.VN)
            }
        }
    }
}
