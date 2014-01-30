import QtQuick.Controls 1.1

ApplicationWindow {
    id: app
    title: "File Browser"
    minimumWidth : 480
    minimumHeight: 320
    width: minimumWidth
    height: minimumHeight
    visible: true

    FileBrowser {
        id: browser
        anchors.fill: parent
        onFilePathChanged: {
            console.log(browser.filePath);
        }
    }
}
