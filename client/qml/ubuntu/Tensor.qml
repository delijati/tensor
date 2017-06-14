import QtQuick 2.4
import Ubuntu.Components 1.3
import Matrix 1.0


MainView {
    id: window

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "tensor.delijati"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(50)
    height: units.gu(75)

    RoomList {
        id: roomlist
    }

    RoomView {
        id: roomview
    }

    PageStack {
        id: pageStack
    }

    property bool initialised: false

    Connection { id: connection }
    Settings   { id: settings }

    function resync() {
        if(!initialised) {
            login.visible = false
            roomlist.init(connection)
            pageStack.push(roomlist)
            initialised = true
        }
        connection.sync(30000)
    }

    function login(user, pass, connect) {
        if(!connect) connect = connection.connectToServer

        connection.connected.connect(function() {
            settings.setValue("user",  connection.userId())
            settings.setValue("token", connection.token())

            connection.connectionError.connect(connection.reconnect)
            connection.syncDone.connect(resync)
            connection.reconnected.connect(resync)

            connection.sync()
        })

        var userParts = user.split(':')
        if(userParts.length === 1 || userParts[1] === "matrix.org") {
            connect(user, pass)
        } else {
            connection.resolved.connect(function() {
                connect(user, pass)
            })
            connection.resolveError.connect(function() {
                console.log("Couldn't resolve server!")
            })
            connection.resolveServer(userParts[1])
        }
    }

    Login {
        id: login
        window: window
        anchors.fill: parent
        Component.onCompleted: {
            var user =  settings.value("user")
            var token = settings.value("token")
            if(user && token) {
                login.login(true)
                window.login(user, token, connection.connectWithToken)
            }
        }
    }
}
