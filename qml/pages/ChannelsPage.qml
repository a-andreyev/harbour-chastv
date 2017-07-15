import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    allowedOrientations: Orientation.All
    property alias model: gridView.model

    SilicaGridView {
        VerticalScrollDecorator{}
        PullDownMenu {
            MenuItem {
                text: qsTr("О программе")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }
        id: gridView
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Каналы")
        }
        cellWidth: page.orientation & Orientation.PortraitMask ? (gridView.width / 3) : (gridView.width / 7)
        cellHeight: cellWidth

        delegate: BackgroundItem {
            width: gridView.cellWidth
            height: gridView.cellHeight
            Rectangle {
                visible: !image.source
                anchors.fill: parent
                color: Qt.rgba(Math.random(),Math.random(),Math.random(),0.5);
            }

            OpacityRampEffect {
                visible: !image.source
                sourceItem: label
                offset: 0.5
            }

            Label {
                visible: !image.source
                id: label
                x: Theme.paddingMedium; y: Theme.paddingLarge
                width: parent.width - y
                textFormat: Text.StyledText
                text: model.channelId
                font {
                    pixelSize: Theme.fontSizeLarge
                    family: Theme.fontFamilyHeading
                }
            }
            Image {
                id: image
                anchors.fill: parent
                anchors.margins: Theme.paddingLarge
                source: "../assets/ch_icons/"+model.channelId+".png"
                fillMode: Image.PreserveAspectFit
            }
            onClicked: {
                onClicked: pageStack.push(Qt.resolvedUrl("ChannelPage.qml"),{channelId:model.channelId, channelLogoUrl: image.source})
            }
        }
    }
}

