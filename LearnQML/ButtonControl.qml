import QtQuick 2.0

MouseArea{
    id: root
    property string default_: ""
    property string pressed_: ""
    property string released_: ""
    property alias source_: mimage.source

    implicitHeight: mimage.height
    implicitWidth: mimage.width
    Image{
        id:mimage
        source: default_
    }
    onPressed: mimage.source = pressed_
    onReleased: mimage.source = released_
}
