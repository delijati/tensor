import QtQuick 2.0
import QtQuick.Controls 1.0
import Matrix 1.0
import Tensor 1.0
import 'jschat.js' as JsChat

Rectangle {
    color: Theme.roomListBg

    signal enterRoom(var room)
    signal joinRoom(string name)

    property bool initialised: false

    RoomListModel {
        id: rooms

        onDataChanged: {
            // may have received a message but if focused, mark as read
            var room = currentRoom()
            if (room != null) room.markAllMessagesAsRead()

        }
    }

    function setConnection(conn) {
        rooms.setConnection(conn)
    }

    function init() {
        var defaultRoom = "#tensor:matrix.org"
        initialised = true
        var found = false
        for (var i = 0; i < rooms.rowCount(); i++) {
            if (rooms.roomAt(i).canonicalAlias === defaultRoom) {
                roomListView.currentIndex = i
                enterRoom(rooms.roomAt(i))
                found = true
            }
        }
        if (!found) joinRoom(defaultRoom)
    }

    function refresh() {
        if(roomListView.visible)
            roomListView.forceLayout()
    }

    function changeRoom(dir) {
        roomListView.currentIndex = JsChat.posmod(roomListView.currentIndex + dir, roomListView.count);
        enterRoom(rooms.roomAt(roomListView.currentIndex))
    }

    function currentRoom() {
        if (roomListView.currentIndex < 0) return null
        var room = rooms.roomAt(roomListView.currentIndex)
        return room
    }

    Column {
        anchors.fill: parent

        ListView {
            id: roomListView
            model: rooms
            width: parent.width
            height: parent.height - textEntry.height

            delegate: Rectangle {
                width: parent.width
                height: Math.max(20, roomLabel.implicitHeight + 4)
                color: "transparent"

                Label {
                    id: roomLabel
                    text: display
                    color: roomEventState == "highlight" ? Theme.highlightRoomFg : (roomEventState == "unread" ? Theme.unreadRoomFg : Theme.normalRoomFg)
                    elide: Text.ElideRight
                    font.family: Theme.nickFont
                    font.bold: roomListView.currentIndex == index
                    anchors.margins: 2
                    anchors.leftMargin: 6
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        roomListView.currentIndex = index
                        enterRoom(rooms.roomAt(index))
                    }
                }
            }

            highlight: Rectangle {
                height: 20
                radius: 2
                color: Theme.roomListSelectedBg
            }
            highlightMoveDuration: 0

            onCountChanged: if(initialised) {
                roomListView.currentIndex = count-1
                enterRoom(rooms.roomAt(count-1))
            }

        }

        TextField {
            id: textEntry
            width: parent.width
            placeholderText: qsTr("Join room...")
            onAccepted: { joinRoom(text); text = "" }
        }
    }
}
