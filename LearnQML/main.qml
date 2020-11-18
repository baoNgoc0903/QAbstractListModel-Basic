import QtQuick 2.6
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.1
import QtMultimedia 5.14

ApplicationWindow {
    id: root
    visible: true
    width: 1290
    height: 720
    title: qsTr("Media Player")
    Image {
        id: backgroud
        anchors.fill: parent
        source: "qrc:/Image/background.png"
    }
    Image {
        id: headerItem
        source: "qrc:/Image/title.png"
        Text {
            id: headerTitleText
            text: qsTr("Media Player")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46
        }
    }
    ListModel {
        id: appModel
        ListElement {
            title: "Phố Không Mùa";
            singer: "Bùi Anh Tuấn" ;
            icon: "qrc:/Image/Bui-Anh-Tuan.png";
            source: "qrc:/Music/Pho-Khong-Mua-Duong-Truong-Giang-ft-Bui-Anh-Tuan.mp3"
        }
        ListElement {
            title: "Chuyện Của Mùa Đông";
            singer: "Hà Anh Tuấn" ;
            icon: "qrc:/Image/Ha-Anh-Tuan.png";
            source: "qrc:/Music/Chuyen-Cua-Mua-Dong-Ha-Anh-Tuan.mp3"
        }
        ListElement {
            title: "Hongkong1";
            singer: "Nguyễn Trọng Tài" ;
            icon: "qrc:/Image/Hongkong1.png";
            source: "qrc:/Music/Hongkong1-Official-Version-Nguyen-Trong-Tai-San-Ji-Double-X.mp3"
        }
        ListElement {
            title: "Symphony";
            singer: "Zara Larsson" ;
            icon: "qrc:/Image/zara-larsson-symphony-video.jpg";
            source: "qrc:/Music/Symphony.mp3"
        }
        ListElement {
            title: "Until you";
            singer: "Shayne ward" ;
            icon: "qrc:/Image/until you.jpg";
            source: "qrc:/Music/Until+You.mp3"
        }
    }
    // playbackState: giữ trạng thái phát lại của media(phát lại 1 cái đã phát dở, phát cái chưa phát, phát lại 1 cái
    //position: vị trí phát lại hiện tại
    // duration: thời lượng của media

    MediaPlayer{
        id: player
        property bool shuffer: false
        onPlaybackStateChanged: {
            if (playbackState === MediaPlayer.StoppedState && position == duration){
                if (player.shuffer) {
                    var newIndex = Math.floor(Math.random() * mediaPlaylist.count) // chọn random cái index mới
                    while (newIndex === mediaPlaylist.currentIndex)//nếu cái newindex được random ra mà nó bằng cái cũ thì chọn lại
                    {
                        newIndex = Math.floor(Math.random() * mediaPlaylist.count)
                    }
                    mediaPlaylist.currentIndex = newIndex // khác rồi thì gán thôi
                }
                //
                else if(!repeater.baongoc && mediaPlaylist.currentIndex < mediaPlaylist.count - 1) {
                    mediaPlaylist.currentIndex = mediaPlaylist.currentIndex + 1;
                }
            }
        }
        autoPlay: true
    }

    Image {
        id: playList_bg
        anchors.top: headerItem.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 493
        source: "qrc:/Image/playlist.png"
        opacity: 0.2
    }
    ListView {
        id: mediaPlaylist
        anchors.fill: playList_bg
        model: appModel
        clip: true
        spacing: 2
        currentIndex: 0
        delegate: MouseArea {
            property var myData: model
            implicitWidth: playlistItem.width
            implicitHeight: playlistItem.height
            Image {
                id: playlistItem
                width: 675
                height: 193
                source: "qrc:/Image/playlist.png"
                opacity: 0.5
            }
            Text {
                text: title
                anchors.fill: parent
                anchors.leftMargin: 70
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.pixelSize: 32
            }
            onClicked: {
                mediaPlaylist.currentIndex = index
            }

            onPressed: {
                playlistItem.source = "qrc:/Image/hold.png"
            }
            onReleased: {
                playlistItem.source = "qrc:/Image/playlist.png"
            }
        }
        highlight: Image {
            source: "qrc:/Image/playlist_item.png"
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/Image/playing.png"
            }
        }
        ScrollBar.vertical: ScrollBar {
            parent: mediaPlaylist.parent
            anchors.top: mediaPlaylist.top
            anchors.left: mediaPlaylist.right
            anchors.bottom: mediaPlaylist.bottom
        }
        onCurrentItemChanged: {
            album_art_view.currentIndex = currentIndex
            player.source = mediaPlaylist.currentItem.myData.source
            player.play()
        }
    }
    Text {
        id: audioTitle
        anchors.top: headerItem.bottom
        anchors.topMargin: 20
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 20
        text: mediaPlaylist.currentItem.myData.title
        color: "white"
        font.pixelSize: 36
        onTextChanged: {
            textChangeAni.targets = [audioTitle,audioSinger]
            textChangeAni.restart()
        }
    }
    Text {
        id: audioSinger
        anchors.top: audioTitle.bottom
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 20
        text: mediaPlaylist.currentItem.myData.singer
        color: "white"
        font.pixelSize: 32
    }

    NumberAnimation {
        id: textChangeAni
        property: "opacity"
        from: 0
        to: 1
        duration: 493
        easing.type: Easing.InOutQuad
    }
    Text {
        id: audioCount
        anchors.top: headerItem.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        text: mediaPlaylist.count
        color: "white"
        font.pixelSize: 36
    }
    Image {
        anchors.top: headerItem.bottom
        anchors.topMargin: 23
        anchors.right: audioCount.left
        anchors.rightMargin: 10
        source: "qrc:/Image/music.png"
    }
    Component{
        id: appDelegate
        Item{
            scale: PathView.scale
            width: 300
            height: 300
            Image{
                id: myIcon
                width: parent.width
                height: parent.height
                anchors.margins: 5
                anchors.verticalCenter: parent.verticalCenter
                source: icon
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                     album_art_view.currentIndex = index
                }
            }
        }
    }

    PathView{
        id: album_art_view
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 50
        anchors.top: headerItem.bottom
        anchors.topMargin: 250
        model: appModel
        delegate: appDelegate
        focus: true
        pathItemCount: 3
        Keys.onRightPressed: decrementCurrentIndex()
        Keys.onLeftPressed: incrementCurrentIndex()
        path: Path{
            startX: 550; startY: 50
            PathAttribute{name: "scale"; value: 1}
            PathLine{
                x:1100 ; y: 50
            }
            PathAttribute{name: "scale"; value: 0.7}
            PathLine{
                x:0;y:50
            }
            PathAttribute{name: "scale"; value: 0.7}
            PathLine{
                x:550; y:50
            }
            PathAttribute{name: "scale"; value: 1}
        }
        onCurrentIndexChanged: {
            mediaPlaylist.currentIndex = currentIndex
        }

    }

    //Progress
    function getTime(time){
        var seconds = parseInt((time/1000)%60);
        var minutes = parseInt((time/(1000*60))%60);

        minutes = (minutes < 10) ? "0" + minutes : minutes;
        seconds = (seconds < 10) ? "0" + seconds : seconds;

        return minutes + ":" + seconds;
    }

    Text {
        id: currentTime
        anchors.verticalCenter: progressBar.verticalCenter
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 120
        text: getTime(player.position)
        color: "white"
        font.pixelSize: 24
    }
    Slider{
        id: progressBar
        width: 816
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 200
        anchors.left: currentTime.right
        anchors.leftMargin: 20
        from: 0
        to: player.duration
        value: player.position
        background: Rectangle {
            x: progressBar.leftPadding
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: progressBar.availableWidth
            height: implicitHeight
            radius: 2
            color: "gray"

            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: 2
            }
        }
        handle: Image {
            anchors.verticalCenter: parent.verticalCenter
            x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            source: "qrc:/Image/point.png"
            Image {
                anchors.centerIn: parent
                source: "qrc:/Image/center_point.png"
            }
        }
        onMoved: {
            if (player.seekable){
                player.seek(progressBar.value)
            }
        }
    }
    Text {
        id: totalTime
        anchors.verticalCenter: progressBar.verticalCenter
        anchors.left: progressBar.right
        anchors.leftMargin: 20
        text: getTime(player.duration)
        color: "white"
        font.pixelSize: 24
    }

    //Control Media
    SwitchButton{
        id: shuffer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 93
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 93
        icon_off: "qrc:/Image/shuffle-1.png"
        icon_on: "qrc:/Image/shuffle.png"
        baongoc: player.shuffer
        onBaongocChanged: {
            if(repeater.baongoc && baongoc){
                repeater.baongoc = false
                player.shuffer = true
            }
        }
    }

    ButtonControl{
        id:prev
        anchors.verticalCenter: shuffer.verticalCenter
        anchors.left: shuffer.right
        anchors.leftMargin: 220
        default_: "qrc:/Image/prev.png"
        pressed_: "qrc:/Image/hold-prev.png"
        released_: "qrc:/Image/prev.png"
        onClicked: {
            mediaPlaylist.currentIndex = (mediaPlaylist.currentIndex===0)? (mediaPlaylist.count-1) : (mediaPlaylist.currentIndex-1)
        }
    }
    ButtonControl{
        id: play
        anchors.verticalCenter: prev.verticalCenter
        anchors.left: prev.right
        anchors.leftMargin: 5
        default_: player.playbackState===MediaPlayer.PlayingState?"qrc:/Image/pause.png":"qrc:/Image/play.png"
        pressed_: player.playbackState===MediaPlayer.PlayingState?"qrc:/Image/hold-pause.png":"qrc:/Image/hold-play.png"
        released_:  player.playbackState===MediaPlayer.PlayingState? "qrc:/Image/play.png" : "qrc:/Image/pause.png"
        onClicked:{
            if(player.playbackState===MediaPlayer.PlayingState)
            {
                player.pause();
            }
            else{
                player.play();
            }
        }
        Connections{
            target: player
            onPlaybackStateChanged:{
                if(player.playbackState===MediaPlayer.PlayingState){
                    play.source_ = "qrc:/Image/pause.png"
                }
            }
        }

    }
    ButtonControl{
        id:next
        anchors.verticalCenter: shuffer.verticalCenter
        anchors.left: play.right
        anchors.leftMargin: 5
        default_: "qrc:/Image/next.png"
        pressed_: "qrc:/Image/hold-next.png"
        released_: "qrc:/Image/next.png"
        onClicked: {
            mediaPlaylist.currentIndex = (mediaPlaylist.currentIndex===mediaPlaylist.count-1)? 0 : (mediaPlaylist.currentIndex+1)
        }
    }
    SwitchButton {
        id: repeater
        anchors.verticalCenter: shuffer.verticalCenter
        anchors.right: totalTime.right
        icon_on: "qrc:/Image/repeat.png"
        icon_off: "qrc:/Image/repeat1_hold.png"
        onBaongocChanged:{
           if(baongoc){
               if(shuffer.baongoc){
                   shuffer.baongoc = false
                   player.shuffer = false;
               }
               player.loops = MediaPlayer.Infinite
           }else{
                player.loops = 0
           }
        }
    }

}
