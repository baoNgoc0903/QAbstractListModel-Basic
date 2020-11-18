import QtQuick 2.0

MouseArea{
    id: root
    property string icon_off:""
    property string icon_on:""
    property bool baongoc: false // baongoc == status
    implicitWidth:mimage.width
    implicitHeight: mimage.height
    Image{
        id: mimage
        source: root.baongoc? icon_off : icon_on
    }
    onClicked: {
        root.baongoc = !root.baongoc
    }
}
