import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.5
import Sailfish.Media 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All
    backNavigation: drawer.open

    property string channelId
    property string channelName
    property alias channelUrl: video.source
    property url channelLogoUrl
    property string nowPlayingText
    property string nextPlayingText
    property string descriptionText

    Component.onCompleted: {
        chasTVApp.updateCurrentChannelInfo.connect(updateChannelData)
        updateChannelData()
    }

    signal htmlReady(string html)

    function updateChannelData() {
        if (chasTVApp) {
            const host = "http://chas.tv"
            const channelPath = "/channel"
            const chUrl = host+channelPath+"/"+channelId
            chasTVApp.request(chUrl, function (o) {
                htmlReady(o.responseText)
            });
        }
    }

    onHtmlReady: {
        const regexChName = /<h1 class="pull-left">.+<\/h1>/g;
        const regexChUrl = /this.videoplayer = new Uppod\({m:"video",uid:"videoplayer",file:".+"}\);/g;

        // Title:
        if (!channelName) {
            var m;
            while ((m = regexChName.exec(html)) !== null) {
                // This is necessary to avoid infinite loops with zero-width matches
                if (m.index === regexChName.lastIndex) {
                    regexChName.lastIndex++;
                }
                // The result can be accessed through the `m`-variable.
                channelName = m[0].replace("<h1 class=\"pull-left\">","").replace("</h1>","")
            }
        }

        // Url:
        if (video.status===MediaPlayer.NoMedia) {
            while ((m = regexChUrl.exec(html)) !== null) {
                // This is necessary to avoid infinite loops with zero-width matches
                if (m.index === regexChName.lastIndex) {
                    regexChName.lastIndex++;
                }

                // The result can be accessed through the `m`-variable.
                channelUrl = m[0].split("\"").slice(-2)[0]
                // console.log(channelUrl)
            }
        }

        // Now playing:
        var nowPlaying = html.match(/<span class="channel-tv-program-current">( |[\r\n])+.+<\/span>/g)[0].trim();
        if (nowPlaying) {
            nowPlayingText = nowPlaying
        }
        // Next playing:
        var nextPlayingTitle = html.match(/<span class="channel-tv-program-next">( |[\r\n])+.+( |[\r\n]).+<\/span>/g)[0].trim()
        var nextPlayingTime = html.match(/<span class="channel-tv-program-next-minutes-left">( |[\r\n])+.+( |[\r\n]).+<\/span>/g)[0].trim().replace("минуты","").replace("минут","");
        if (nextPlayingTitle) {
            nextPlayingText = "Через " + nextPlayingTime + " мин.: " + nextPlayingTitle
        }

        // Description:
        if (!descriptionText) {
            var dm = html.match(/<p><strong>Описание:<\/strong> +.+<\/p>/g)
            if (dm) {
                var descr = dm[0].trim()
                if (descr) {
                    descriptionText = descr
                }
            }
        }

        chasTVApp.currentChannelChanged(channelLogoUrl, channelName, nowPlayingText, nextPlayingText)
    }

    Drawer {
        id: drawer
        anchors.fill: parent

        dock: page.orientation & Orientation.PortraitMask ? Dock.Top: Dock.Left
        hideOnMinimize: true

        open: true

        background: SilicaFlickable {
            VerticalScrollDecorator{}
            anchors.fill: parent
            contentHeight: content.height
            PullDownMenu {
                MenuItem {
                    text: "Обновить программу передач"
                    onClicked: updateChannelData()
                }
            }
            PushUpMenu {
                MenuItem {
                    text: "Перезапустить поток"
                    onClicked: {
                        video.source = ""
                        updateChannelData()
                    }
                }
            }

            Column {
                id: content
                width: parent.width
                PageHeader {
                    width: parent.width
                    title: page.channelName
                }
                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: Theme.horizontalPageMargin
                    Label {
                        width: parent.width
                        font.pixelSize: Theme.fontSizeLarge
                        text: page.nowPlayingText
                        wrapMode: Text.WordWrap
                    }
                    Label {
                        width: parent.width
                        font.pixelSize: Theme.fontSizeSmall
                        text: page.nextPlayingText
                        wrapMode: Text.WordWrap
                        color: Theme.secondaryColor
                    }

                    Item {
                        visible: descriptionText
                        width: parent.width
                        height: Theme.paddingLarge
                    }

                    Label {
                        width: parent.width
                        font.pixelSize: Theme.fontSizeMedium
                        text: page.descriptionText
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
        Image {
            visible: (video.playbackState !== MediaPlayer.PlayingState)
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: channelLogoUrl
            scale: 0.5
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!drawer.open) {
                    updateChannelData()
                }
                drawer.open = !drawer.open
            }
        }

        Video {
            autoPlay: true
            width: drawer.foregroundItem.width
            height: drawer.foregroundItem.height
            id: video

            fillMode: drawer.open ? VideoOutput.PreserveAspectCrop : VideoOutput.PreserveAspectFit
        }
    }

    ScreenBlank {suspend: true}

}
