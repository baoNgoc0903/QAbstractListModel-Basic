import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
Window {
    id: root
    Connections{
        target: nickname
        onVisibleSignal:{
            root.visible = true
        }
    }
    width: 640
    height: 480
    title: qsTr("Person ui1")
    Text{
        id: mtext
        text:"Message: "
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
    Button{
        id:but1
        text:"Send"
        anchors{
            right: parent.right
            rightMargin: 10
            verticalCenter: mtext.verticalCenter
        }
        background: Rectangle{
            implicitWidth: 70
            implicitHeight: 30
            color: but1.down ? "#d6d6d6" : "#f6f6f6"
            border.color: "#26282a"
            border.width: 1
            radius: 4
        }
        enabled: mtextfi.text===""?false : true
        onClicked: {
            nickname.setMessage(mtextfi.text)
            nickname.sendMessage()
            mtextfi.text = ""
        }
    }
    TextField{
        id:mtextfi
        anchors.left: mtext.right
        anchors.right: but1.left
        anchors.rightMargin: 5
        anchors.verticalCenter: mtext.verticalCenter
        placeholderText: qsTr("Enter name")
        background: Rectangle{
            implicitWidth: 70
            implicitHeight: 30
            color: mtextfi.enabled ? "transparent" : "#353637"
            border.color: mtextfi.enabled ? "#26282a" : "transparent"
        }
    }
    TextArea{
        id: mtextar
        readOnly: true
        anchors{
            left: mtext.left
            right: but1.right
            bottom:mtextfi.top
            bottomMargin: 5
            top: parent.top
            topMargin: 5
        }
        background: Rectangle{
            border.color: mtextar.enabled ? "#26282a" : "transparent"
        }
    }
    Connections{
        target: nickname
        onReceiveNameChanged:{
            mtextar.text += name +" joins group chat" + '\n'
        }
        onReceiveMessageChanged:{
            mtextar.text += "<"+name+">: " + message + '\n'
        }
    }
}
