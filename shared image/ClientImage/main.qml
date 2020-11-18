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
        text: "Open Image"
        onClicked: {
            m_cli_image.m_path = "file://" + m_cli_image.openImage()
        }
    }
    Image {
        id: image
        anchors.top: but1.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        fillMode: Image.PreserveAspectFit
        source: m_cli_image.m_path
    }
}
