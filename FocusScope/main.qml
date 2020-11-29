import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property alias check1: input1.activeFocus
    property alias check2: input2.activeFocus
    Column{
        x:100
        y:100
        spacing: 5
        TLineEdit{
            id: input1
            focus: true
            color: input1.activeFocus?"lightsteelblue" : "transparent"
            KeyNavigation.tab: input2
        }
        TLineEdit{
            id:input2
            color: input2.activeFocus?"lightsteelblue" : "transparent"
            KeyNavigation.tab: input1
        }
    }

    Text{
        id: mtext
        text: disPlay()
    }
    function disPlay(){
        if(root.check1){
            return "focus on input1"
        }
        else if(root.check2){
            return "focus on input2"
        }
    }
}
