import QtQuick 2.4
import Ubuntu.Components 1.3
import Matrix 1.0


BasePage {
    id: roomlist
    title: i18n.tr("RoomList")
    visible: false

    RoomListModel {
        id: rooms
    }

    function setConnection(conn) {
        rooms.setConnection(conn)
    }

    function init(connection) {
        setConnection(connection)
        roomview.setConnection(connection)
        console.log("Rooms: " + rooms.rowCount())
        for(var i = 0; i < rooms.rowCount(); i++) {
            console.log(rooms.roomAt(i).name)
        }
    }

    function refresh() {
        if(roomListView.visible)
        roomListView.forceLayout()
    }

    function currentRoom(index) {
        console.log("Current room: " + index)
        if (index < 0) return null
        var room = rooms.roomAt(index)
        return room
    }

    Column {
        anchors.fill: parent

        ListView {
            id: roomListView
            model: rooms
            width: parent.width
            height: parent.height

            Component.onCompleted: {
                visible = true;
            }

            delegate: ListItem {

                Row {
                    id: rowItem
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: units.gu(1)
                    anchors.rightMargin: units.gu(1)
                    spacing: units.gu(1)

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: display
                    }
                }

                onClicked: {
                    roomListView.currentIndex = index
                    roomview.setRoom(rooms.roomAt(index))
                    pageStack.push(roomview)
                }

                leadingActions: ListItemActions {
                    actions: [
                        Action {
                            iconName: "delete"
                            text: i18n.tr("Leave")
                            onTriggered: {
                                var current = currentRoom(index)
                                if (current !== null) {
                                    leaveRoom(current)
                                    // TODO we need a left room event
                                    console.log("Leaving room: " + display)
                                    refresh()
                                } else {
                                    console.log("Unable to leave room: " + current)
                                }
                            }
                        }
                    ]
                }

            }

        }
    }
}
