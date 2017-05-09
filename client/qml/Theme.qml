pragma Singleton

import QtQuick 2.0
import Matrix 1.0

QtObject {
    property Settings settings: null

    property string textFont: ""
    property string nickFont: ""
    property int textSize: 11
    property string roomListBg: ""
    property string chatBg: ""
    property string roomListSelectedBg: ""
    property string unreadRoomFg: ""
    property string highlightRoomFg: ""
    property string normalRoomFg: ""

    function loadFromSettings(settings) {
        if (settings != null) {
            textFont = settings.value("Theme/textFont", "Consolas")
            nickFont = settings.value("Theme/nickFont", textFont)
            textSize = settings.value("Theme/textSize", 11)
            chatBg = settings.value("Theme/chatBg", "#fdf6e3")
            roomListBg = settings.value("Theme/roomListBg", "#6a1b9a")
            roomListSelectedBg = settings.value("Theme/roomListSelectedBg", "#9c27b0")
            unreadRoomFg = settings.value("Theme/unreadRoomFg", "white")
            highlightRoomFg = settings.value("Theme/highlightRoomFg", "white")
            normalRoomFg = settings.value("Theme/normalRoomFg", "#dddddd")
        }
    }

}
