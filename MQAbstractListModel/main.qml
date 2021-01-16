import QtQuick 2.12
import QtQuick.Window 2.12



Window {
    visible: true
    width: 200
    height: 300
    title: qsTr("Hello World")
    ListView{
        id: mlistview
        anchors.fill: parent
        clip: true
        model: mclass
//        focus: true
        delegate: Rectangle{
            width: parent.width
            height: txt1.implicitHeight+txt2.implicitHeight+txt3.implicitHeight+txt4.implicitHeight+4
            color: "transparent"
            border.color: "green"
            border.width: 0.5
            Column{
                Text{
                    id: txt1
                    text: date
                }
                Text{
                    id: txt2
                    text: age
                }
                Text{
                    id: txt3
                    text: name
                }
                Text{
                    id: txt4
                    text: love
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mlistview.currentIndex = index
                }
            }
        }
        highlight: Rectangle{
            color: "green"
        }
    }
//    Text{
//        text:convertTimeFormat(dat.date)
//    }
//    function convertTimeFormat(txt)
//    {
//            return (Date.fromLocaleString( txt, "d.M h.mmA").toLocaleString(Qt.locale("en_EN"), "dd.MM hh:mm A"))
//    }
}
