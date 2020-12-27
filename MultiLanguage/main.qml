import QtQuick 2.12
import QtQuick.Window 2.12
import MyLanguage 1.0
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    ListView{
        id: mlistview
        width: parent.width/2
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        spacing: 10
        clip: true
        focus: true
        model: MListModel{}
        delegate: Rectangle{
            width: parent.width
            height: 60
            color: "lightsteelblue"
            Text{
                text: qsTr(mtext) + mytrans.emptySting
                anchors.centerIn: parent
                font.pixelSize: 20
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mlistview.currentIndex = index
                    console.log(mlistview.currentIndex)
                }
            }
        }
    }
    Column{
        spacing: 5
        MButton{
            mtext: "ENG"
            onMclick: {
                mytrans.updateLanguage(MyLanguage.ENG)
                console.log("why ENG")
            }
        }
        MButton{
            mtext: "VN"
            onMclick: {
                mytrans.updateLanguage(MyLanguage.VN)
                console.log("why VN")
            }
        }
    }
}
