import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id: root
    property bool mvisible: true
    property string msource: "qrc:/Item1.qml"
//    property int xText: item5.x
    signal pageMain()
    Top_Bar{
        visible: mvisible
        id: topbar
        text: "Try Learn To Have Money"
        onPageMain: {
            root.pageMain()
        }
        /* khai báo 1 cái property cấp 1 trong object - là file qml
         thì sẽ dùng được mọi nơi trong file qml đấy chỉ bằng name của
         property đó*/
        property int xText: item5.x
    }
    Rectangle{
        visible: mvisible
        id: itemlistview
        width: 100
        anchors{
            top: topbar.bottom
            bottom: parent.bottom
            left: parent.left
        }
        color: "red"
        border.color: "black"
        border.width: 0.5
        ListView{
            id: mlistview
            anchors.fill: parent
            anchors.margins: 0.5
            spacing: 5
            model: MyModel{}
            clip: true
            focus: true
            delegate: Rectangle{
                x:0.5
                width: parent.width
                height: text1.implicitHeight+4
                color: "lightsteelblue"
                opacity: 0.5
                Text{
                    id: text1
                    text: mtext
                    anchors.centerIn: parent
                    font.pixelSize: 15
                    font.bold: true
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mlistview.currentIndex = index
                    }
                }
            }
            highlight: Rectangle{
                width: parent.width
                color: "green"
                x:0.5
            }
        }
    }
    Connections{
        target: mlistview
        onCurrentIndexChanged:{
//            console.log(mlistview.currentIndex)
            loadQml(mlistview.currentIndex)
        }
    }
    Item{
        visible: mvisible
        anchors{
            top: topbar.bottom
            left:itemlistview.right
            right: parent.right
            bottom: parent.bottom
        }
        Loader{
            id: mloader
            anchors.centerIn: parent
            source: root.msource
        }
    }
    Button{
        visible: mvisible
        id: button2
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        width: 20
        height: 40
        background: Rectangle{
            color: button2.down?"green":"grey"
        }
        visible: screen2.mvisible
        onClicked:{
            item5.state = item5.state ==="DISIBLE"?"ENABLE":'DISIBLE'
        }

        z:1 // hiện bên trên thằng Item5
    }
    Item5{
        id: item5
        anchors.top: parent.top
        x:0
        anchors.topMargin: 40
        state: "DISIBLE"
        states: [
            State{
                name:"DISIBLE"
                PropertyChanges{target:item5;x: 640}
            },
            State{
                name:"ENABLE"
                PropertyChanges{target:item5;x: 440}
            }
        ]
        transitions:[
            Transition {
                from: "DISIBLE"
                to: "ENABLE"
                NumberAnimation{property: "x";duration: 1000}
            },
            Transition {
                from: "ENABLE"
                to: "DISIBLE"
                NumberAnimation{property: "x";duration: 1000}
            }
        ]
    }

    function loadQml(index){
        if(index ===0){
            root.msource ="qrc:/Item1.qml"
        }
        else if(index ===1){
            root.msource ="qrc:/Item2.qml"
        }
        else if(index ===2){
            root.msource ="qrc:/Item3.qml"
        }
        else if(index ===3){
            root.msource ="qrc:/Item4.qml"
        }
    }
}
