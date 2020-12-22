import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window{
    id: root
    width: 1280/2
    height: 720/2
    visible: true
    title: qsTr("qml")
    Button{
        id: button1
        text: "Click me"
        onClicked: {
            screen2.mvisible = true
            button1.visible = false
        }
    }

    Screen2{
        id: screen2
        anchors.fill: parent
        mvisible: false
    }
    Connections{
        target: screen2
        onPageMain:{
            screen2.mvisible = false
            button1.visible = true
        }
    }
}
