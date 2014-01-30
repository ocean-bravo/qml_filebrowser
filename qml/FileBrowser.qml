import QtQuick 2.2
import Qt.labs.folderlistmodel 2.0
import QtQuick.Controls 1.1

Item {
    id: root
    width: 200
    height: 300
    property string filePath: list.model.get(list.currentIndex, "filePath")
    property real spacing: 6
    property string selectedNameFilter: "*.*"

    property alias color: background.color

    function __dirDown(url) {
        list.model.folder = url;
        list.currentIndex = -1;
    }

    function __dirUp() {
        list.model.folder = list.model.parentFolder;
        list.currentIndex = -1;
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: __palette.window
        Rectangle {
            id: titleBar
            width: parent.width
            height: 25
            color: Qt.darker(__palette.window, 1.2)
            border.color: Qt.darker(__palette.window, 1.3)

            Button {
                id: upButton
                height: parent.height
                width: height
                anchors.left: parent.left
                iconSource: "qrc:///images/up.png"
                onClicked:  {
                    if (list.model.parentFolder.toString() !== "") {
                        __dirUp();
                    }
                }
            }
            ComboBox {
                id: driveList
                anchors.left: upButton.right
                model: DriveList.availableDrives
                onCurrentIndexChanged: {
                    list.model.folder = "file:///" + currentText;
                }
                Component.onCompleted: {
                    list.model.folder = "file:///" + currentText;
                }
            }
            Text {
                id: currentPathText
                height: parent.height
                anchors.left: driveList.right
                anchors.right: parent.right
                text: list.model.folder
                color: __palette.text
                elide: Text.ElideLeft
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
        }
        ScrollView {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: titleBar.bottom
            anchors.bottom: parent.bottom

            ListView {
                id: list
                clip: true
                focus: true
                model: FolderListModel {
                    showDirsFirst: true
                    sortField: FolderListModel.Name
                    onFolderChanged: {
                        currentPathText.text = list.model.folder.toString().replace("file:///", "");
                    }
                }
                delegate: folderDelegate
                highlight: Rectangle {
                    color: __palette.midlight
                    border.color: Qt.darker(__palette.window, 1.3)
                }
                // подсветка следит за фокусом и перемещается мгновенно
                highlightMoveDuration: -1
                highlightMoveVelocity: -1
                highlightFollowsCurrentItem: true
            }
        }
        SystemPalette { id: __palette }

        Component {
            id: folderDelegate
            Rectangle {
                id: wrapper
                width: root.width
                height: nameText.implicitHeight * 1.5
                color: "transparent"

                Image {
                    id: icon
                    source: "qrc:///images/folder.png"
                    height: parent.height - spacing * 2
                    width: height
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: spacing
                    anchors.topMargin: spacing
                    visible: list.model.isFolder(index)
                    property int spacing: 2
                }
                Text {
                    id: nameText
                    text: fileName
                    anchors.left: icon.right
                    anchors.leftMargin: icon.spacing
                    anchors.right: parent.right
                    verticalAlignment: Text.AlignVCenter
                }
                MouseArea {
                    id: mouseRegion
                    anchors.fill: parent
                    onDoubleClicked: {
                        if (list.model.isFolder(index)) {
                            __dirDown(fileURL) // fileURL - это свойство стало доступно из FolderListModel
                        }
                    }
                    onClicked: {
                        list.currentIndex = index;
                    }
                }
            }
        }
    }
}
