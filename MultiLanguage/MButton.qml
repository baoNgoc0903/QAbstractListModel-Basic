import QtQuick 2.0

Rectangle{
    signal mclick()
    width: 60
    height: 30
    border.color: "green"
    color: "lightsteelblue"
    border.width: 1
    property alias mtext: textbtn.text
    Text{
        id: textbtn
        anchors.centerIn: parent
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            mclick()
        }
    }
}
