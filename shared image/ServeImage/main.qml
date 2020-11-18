import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Button{
        id: but1
        text:"Display from shared mem"
        onClicked: {
            m_ser_image.ser_path = ""
        }
    }
    Image{
        id:mimage
        anchors.top: but1.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        fillMode: Image.PreserveAspectFit
        source: m_ser_image.ser_path
    }
}
