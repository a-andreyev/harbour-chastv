# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-chastv

CONFIG += sailfishapp

SOURCES += src/harbour-chastv.cpp

OTHER_FILES += qml/harbour-chastv.qml \
    qml/cover/CoverPage.qml \
    qml/pages/ChannelPage.qml \
    qml/pages/ChannelsPage.qml \
    qml/pages/AboutPage.qml \
    rpm/harbour-chastv.changes.in \
    rpm/harbour-chastv.spec \
    rpm/harbour-chastv.yaml \
    translations/*.ts \
    harbour-chastv.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-chastv-de.ts

DISTFILES += \
    qml/assets/images/rocket.svg \
    qml/assets/images/aa13q.jpeg \
    qml/assets/images/le_me.jpeg \
    qml/assets/images/flattr.svg \
    qml/assets/images/git.svg \
    qml/assets/images/paypal.png \
    qml/assets/images/rocketbank.svg \
    qml/assets/images/chastv.png \
# ch icons
    qml/assets/ch_icons/2x2.png \
    qml/assets/ch_icons/boec.png \
    qml/assets/ch_icons/cartoon-network.png \
    qml/assets/ch_icons/che.png \
    qml/assets/ch_icons/disney.png \
    qml/assets/ch_icons/domashnii.png \
    qml/assets/ch_icons/karusel.png \
    qml/assets/ch_icons/kultura.png \
    qml/assets/ch_icons/lifenews.png \
    qml/assets/ch_icons/match-tv.png \
    qml/assets/ch_icons/moya-planeta.png \
    qml/assets/ch_icons/nst.png \
    qml/assets/ch_icons/ntv.png \
    qml/assets/ch_icons/pervyi.png \
    qml/assets/ch_icons/planeta-rtr.png \
    qml/assets/ch_icons/pyatnica.png \
    qml/assets/ch_icons/rentv.png \
    qml/assets/ch_icons/rossiya-1.png \
    qml/assets/ch_icons/rossiya-24.png \
    qml/assets/ch_icons/rutv.png \
    qml/assets/ch_icons/sts-love.png \
    qml/assets/ch_icons/sts.png \
    qml/assets/ch_icons/tnt.png \
    qml/assets/ch_icons/tv3.png \
    qml/assets/ch_icons/tvc.png \
    qml/assets/ch_icons/zvezda.png
