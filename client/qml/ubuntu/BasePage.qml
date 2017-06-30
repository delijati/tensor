import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3


Page {
    id: basepage

    About {
        id: about
    }

    DialogJoinRoom {
        id: dialogJoinRoom
        property var current: null
    }

    head.actions: [
        Action {
            iconName: "import"
            text: i18n.tr("Join room")
            onTriggered: {
                console.log(dialogJoinRoom)
                console.log(dialogJoinRoom.current)
                // XXX we need to set a caller or popup will not ne shown
                dialogJoinRoom.current = PopupUtils.open(dialogJoinRoom, window);
            }
        },
        Action {
            iconName: "info"
            text: i18n.tr("About")
            onTriggered: {
                pageStack.push(about);
            }
        }
    ]
}
