import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window{
    id: root
    width: 200
    height: 100
    visible: true
    title: qsTr("Nick name ui1")

    TextField{
        focus: true
        id: mtextfield
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("Enter nickname")
        background: Rectangle{
            implicitWidth: root.width-10
            implicitHeight: 30
            color: mtextfield.enabled ? "transparent" : "#353637"
            border.color: mtextfield.enabled ? "#26282a" : "transparent"
        }
    }
    Button{
        objectName: "buttonName"
        id:but1
        text:"oke"
        anchors{
            horizontalCenter: mtextfield.horizontalCenter
            top: mtextfield.bottom
            topMargin: 5
        }
        background: Rectangle{
            implicitWidth: 70
            implicitHeight: 30
            color: but1.down ? "#d6d6d6" : "#f6f6f6"
            border.color: "#26282a"
            border.width: 1
            radius: 4
        }
        enabled: mtextfield.text===""?false : true
        onClicked: {
            nickname.setNameofOwn(mtextfield.text) // tên chủ chat
            nickname.nameChanged(mtextfield.text) // bắn signal name đi
            nickname.visibleSignal() // hiện bảng chat sau khi nhập xong tên
            close()
        }
    }
}
