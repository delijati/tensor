import QtQuick 2.4
import Ubuntu.Components 1.3
import Matrix 1.0


Page {
    id: roomlist
    title: i18n.tr("RoomList")
    visible: false

    signal joinRoom(string name)

    property bool initialised: false

    RoomListModel {
        id: rooms
    }

    function setConnection(conn) {
        rooms.setConnection(conn)
    }

    function init(connection) {
        setConnection(connection)
        roomview.setConnection(connection)
        initialised = true
        var found = false
        console.log("Rooms: " + rooms.rowCount())
        for(var i = 0; i < rooms.rowCount(); i++) {
            console.log(rooms.roomAt(i).name)
        }
    }

    function refresh() {
        if(roomListView.visible)
            roomListView.forceLayout()
    }

    Column {
        anchors.fill: parent

        ListView {
            id: roomListView
            model: rooms
            width: parent.width
            height: parent.height - textEntry.height

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
