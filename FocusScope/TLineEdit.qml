import QtQuick 2.12
FocusScope {
    implicitHeight: mrectangle.height
    implicitWidth: mrectangle.width
    property alias color: mrectangle.color
    Rectangle{
        id: mrectangle
        implicitWidth:  mtextinput.contentWidth+5
        implicitHeight: mtextinput.contentHeight+5
        width: implicitWidth
        height: implicitHeight
        color: "transparent"
        border.width: 2
        border.color: "green"
        radius: 2
        focus: true
        TextInput{
            id: mtextinput
            anchors.fill: parent
            text:"input here"
            focus: true
        }
    }
//    TextInput{
//        id: mtextinput
//        text:"input here"
//        focus: true
//    }
}
