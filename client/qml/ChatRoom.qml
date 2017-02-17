import QtQuick 2.0
import QtQuick.Controls 1.0
import Matrix 1.0
import 'jschat.js' as JsChat

Rectangle {
    id: root

    property Connection currentConnection: null
    property var currentRoom: null


    function setRoom(room) {
        currentRoom = room
        messageModel.changeRoom(room)
        chatView.positionViewAtBeginning()
    }

    function setConnection(conn) {
        currentConnection = conn
        messageModel.setConnection(conn)
    }

    function sendLine(text) {
        if(!currentRoom || !currentConnection) return
        currentConnection.postMessage(currentRoom, "m.text", text)
        chatView.positionViewAtBeginning()
    }

    ListView {
        id: chatView
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        verticalLayoutDirection: ListView.BottomToTop
        model: MessageEventModel { id: messageModel }

        delegate: Row {
            id: message
            width: parent.width
            spacing: 8

            Label {
                id: timelabel
                text: time.toLocaleTimeString("hh:mm:ss")
                color: "grey"
            }
            Label {
                id: authorlabel
                width: 100
                elide: Text.ElideRight
                text: eventType == "message" ? author : "***"
                font.family: JsChat.Theme.nickFont()
                color: eventType == "message" ? JsChat.NickColoring.get(author): "lightgrey"
                horizontalAlignment: Text.AlignRight
            }
            Label {
                id: contentlabel
                text: content
                wrapMode: Text.Wrap
                width: parent.width - (x - parent.x) - spacing
                color: eventType == "message" ? "black" : "lightgrey"
                font.family: JsChat.Theme.textFont()
                font.pointSize: JsChat.Theme.textSize()
            }
        }

        section {
            property: "date"
            labelPositioning: ViewSection.CurrentLabelAtStart
            delegate: Rectangle {
                width: parent.width
                height: childrenRect.height
                Label {
                    width: parent.width
                    text: section.toLocaleString(Qt.locale())
                    color: "grey"
                    horizontalAlignment: Text.AlignRight
                }
            }
        }

        onAtYBeginningChanged: {
            if(currentRoom && atYBeginning) currentRoom.getPreviousContent()
        }
    }
}
