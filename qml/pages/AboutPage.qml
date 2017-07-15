import QtQuick 2.1
import Sailfish.Silica 1.0
import "./components"

Page {
    SilicaFlickable {
        contentHeight: column.height+Theme.paddingLarge
        anchors.fill: parent

        VerticalScrollDecorator {}

        Column {
            spacing: Theme.paddingLarge
            id: column
            width: parent.width
            PageHeader {
                title: qsTr("О программе")
                id: header
            }
            SectionHeader {
                text: qsTr("О Час.ТВ")
            }
            IconTextButton {
                text: qsTr("Веб-сайт")+": chas.tv"
                iconSource: "../../assets/images/chastv.png"
                onClicked: {
                    Qt.openUrlExternally("http://chas.tv/");
                }
            }

            SectionHeader {
                text: qsTr("Лицензия")
            }
            Label {
                textFormat: Text.StyledText
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.Wrap
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
                text: qsTr("Приложение разработано Андреевым Алексеем как некоммерческое без участия Chas.TV.
                    Графика для приложения подготовлена разработчиком в Pixeluvo и Inkscape.
                    Приложение разработано с помощью Sailfish IDE
                    в среде GNU/Linux/Archlinux/KDE.
                    Лицинзия: GPLv3")
            }
            SectionHeader {
                text: qsTr("Помощь автору")
            }
            IconTextButton {
                text: "Paypal: paypal.me/aa13q"
                iconSource: "../../assets/images/paypal.png"
                onClicked: {
                    Qt.openUrlExternally("https://paypal.me/aa13q");
                }
            }

            IconTextButton {
                text: "Flattr: flattr.com/profile/aa13q"
                iconSource: "../../assets/images/flattr.svg"
                onClicked: {
                    Qt.openUrlExternally("https://flattr.com/profile/aa13q");
                }
            }

            IconTextButton {
                text: qsTr("Рокетбанк")+": rocketbank.ru/aa13q-alexey-andreyev"
                iconSource: "../../assets/images/rocketbank.svg"
                onClicked: {
                    Qt.openUrlExternally("https://rocketbank.ru/aa13q-alexey-andreyev");
                }
            }

            SectionHeader {
                text: qsTr("Исходники")
            }
            IconTextButton {
                text: "Github: github.com/a-andreyev/harbour-chastv"
                iconSource: "../../assets/images/git.svg"
                onClicked: {
                    Qt.openUrlExternally("https://github.com/a-andreyev/harbour-chastv");
                }
            }

            SectionHeader {
                text: qsTr("Контакты")
            }
            Label {
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.Wrap
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
                text: qsTr("Меня зовут Алексей Андреев. Я аспирант из Санкт-Петербурга. Пожертвования приветствуются.")
            }
            IconTextButton {
                text: qsTr("Мой веб-сайт")+": aa13q.ru"
                iconSource: "../../assets/images/aa13q.jpeg"
                onClicked: {
                    Qt.openUrlExternally("http://aa13q.ru/");
                }
            }
            Image {
                source: "../assets/images/le_me.jpeg"
                fillMode: Image.PreserveAspectFit
                anchors {
                            left: parent.left
                            right: parent.right
                            margins: Theme.paddingLarge
                        }
                height: width
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }
        }
    }
}
