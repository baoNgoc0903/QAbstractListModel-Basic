import QtQuick 2.0
import QtQuick.Controls 2.0
Rectangle{
    id: root
    width: parent.width
    height: 80
    color: "grey"
    property alias text: mtext.text
//    property alias anchor: itemText.anchors
    signal pageMain()
    Item{
        y:0
        width: parent.width
        height: 40
        Button{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            text:"page main"
            onClicked: {
                root.pageMain()
            }
        }
    }

    Item{
        id: itemText
        width: parent.width
        y:40
        height: 40
        Text{
            id: mtext
            font.pixelSize: 15
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: xText/2 - mtext.implicitWidth/2
            anchors{
                verticalCenter: parent.verticalCenter
            }
        }
    }
}
