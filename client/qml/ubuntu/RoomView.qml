import QtQuick 2.4
import Ubuntu.Components 1.3


Page {
    id: roomview
    title: i18n.tr("Room")
    visible: false

    function setRoom(room) {
        title = room.name
        chat.setRoom(room)
    }

    function setConnection(conn) {
        chat.setConnection(conn)
    }

    function sendLine(line) {
        chat.sendLine(line)
        textEntry.text = ''
    }

    ChatRoom {
        id: chat
        anchors.bottom: textEntry.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
    }

    TextField {
        id: textEntry
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        focus: true
        // textColor: "black"
        placeholderText: qsTr("Say something...")
        onAccepted: sendLine(text)
    }

}
