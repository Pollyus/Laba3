import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Window {
    id: dialogWindow
    title: qsTr("Создать новую запись")
    width: 270
    height: 200

    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height

    GridLayout {
        id: dataGrid

        property bool isDataEdited: false
        property int indexEditedItem: -1

        rows: 5
        columns: 2

        anchors {
            fill: parent
            margins: 10
        }

        Label {
            text: qsTr("Название")
            Layout.fillWidth: true
        }

        TextField {
            id: newGameTitle
            placeholderText: qsTr("Добавить название")
            Layout.fillWidth: true
            background: Rectangle {
                border.width: 1
                radius: 5
            }
        }

        Label {
            text: qsTr("Жанр")
            Layout.fillWidth: true
        }

        TextField {
            id: newGameGenre
            placeholderText: qsTr("Добавить жанр")
            Layout.fillWidth: true
            background: Rectangle {
                border.width: 1
                radius: 5
            }
        }

        Label {
            text: qsTr("Компания разработчик")
            Layout.fillWidth: true
        }

        TextField {
            id: newGameCompany
            placeholderText: qsTr("Добавить разработчика")
            Layout.fillWidth: true
            background: Rectangle {
                border.width: 1
                radius: 5
            }
        }

        Label {
            text: qsTr("Платформа")
            Layout.fillWidth: true
        }

        TextField {
            id: newGamePlatform
            placeholderText: qsTr("Добавить платформу")
            Layout.fillWidth: true
            background: Rectangle {
                border.width: 1
                radius: 5
            }
        }

        Button {
            Layout.fillWidth: true
            text: "OK"
            onClicked: dataGrid.isDataEdited ? set() : add();

            function add() {
                gamemodel.addRow([
                    newGameTitle.text, newGameGenre.text,
                    newGameCompany.text, newGamePlatform.text
                ]);
            }

            function set() {
                gamemodel.setRowAt(
                    dataGrid.indexEditedItem, [
                    newGameTitle.text, newGameGenre.text,
                    newGameCompany.text, newGamePlatform.text
                ])
            }
        }

        Button {
            Layout.fillWidth: true
            text: "Отмена"
            onClicked: hide()
        }
    }

    function execute(itemIndex) {
        if(itemIndex !== undefined) {
            let item = gamemodel.getBy(itemIndex);
            newGameTitle.text = item[0];
            newGameGenre.text = item[1];
            newGameCompany.text = item[2];
            newGamePlatform.text = item[3];

            dataGrid.isDataEdited = true;
            dataGrid.indexEditedItem = itemIndex;

            dialogWindow.title = qsTr("Изменить запись");
        } else {
            dialogWindow.title = qsTr("Создать новую запись");
        }

        show()
    }

    onClosing: clear();

    function clear() {
        newGameTitle.text = "";
        newGameGenre.text = "";
        newGameCompany.text = "";
        newGamePlatform.text = "";

        dataGrid.isDataEdited = false;
        dataGrid.indexEditedItem = -1;
    }
}
