/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    id: cover
    function currentChannelChanged(channelLogoUrl, channelName, nowPlayingText, nextPlayingText) {
        chNowPlayingLabel.text = nowPlayingText
        channelLogoImage.source = channelLogoUrl
    }
    Component.onCompleted: {
        chasTVApp.currentChannelChanged.connect(currentChannelChanged)
    }
    Image {
        scale: 0.8
        width: parent.width
        height: width
        anchors.top: parent.top
        fillMode: Image.PreserveAspectFit
        visible: (channelLogoImage.progress!==1)
        anchors.margins: Theme.paddingLarge
        source: "../assets/images/chastv.png"
    }

    Item {
        visible: (channelLogoImage.progress===1)
        anchors.fill: parent
        anchors.margins: Theme.paddingLarge
        Image {
            anchors.top: parent.top
            width: parent.width
            height: width
            fillMode: Image.PreserveAspectFit
            id: channelLogoImage
        }
        OpacityRampEffect {
            direction: OpacityRamp.TopToBottom
            sourceItem: chNowPlayingLabel
            offset: 0.4
            slope: 4
        }
        Label {
            anchors.top: channelLogoImage.bottom
            anchors.topMargin: Theme.paddingSmall
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            id: chNowPlayingLabel
            font.pixelSize: Theme.fontSizeExtraSmall
        }
    }




    CoverActionList {
        id: coverAction
        enabled: (channelLogoImage.progress===1)
        CoverAction {

            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                chasTVApp.updateCurrentChannelInfo()
            }
        }
    }
}

