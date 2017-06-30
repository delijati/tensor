import QtQuick 2.4
import Ubuntu.Components 1.3 // XXX 1.1 has back buttons oO
import QtQuick.Layouts 1.1


Page {
   title: i18n.tr("About")
   id: about
   visible: false

   Flickable {
      id: flickable
      anchors  {
          fill: parent
          margins: units.gu(2)
      }
      contentHeight: contentItem.childrenRect.height

      Column {
         id: col
         anchors.top: parent.top
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.margins: units.gu(2)
         spacing: units.gu(1)

         Label {
            width: parent.width
            horizontalAlignment: Text.Center
            text: i18n.tr("Tensor Matrix client")
            fontSize: "x-large"
         }

         RowLayout {
            width: parent.width
            UbuntuShape {
               Layout.alignment: Qt.AlignHCenter
               width: units.dp(64)
               height: units.dp(64)
               image: Image {
                  source: "../../logo.png"
               }
            }
         }

         Label {
            width: parent.width
            horizontalAlignment: Text.Center
            visible: false
            text: i18n.tr("Version 0.4")
         }

         Item { height: units.gu(2); width: parent.width } // Spacer

         Label {
            text: i18n.tr("Author: davidar, delijati")
            horizontalAlignment: Text.Center
            width: parent.width
         }

         Label {
            text: i18n.tr("Source code available on <a href='https://github.com/delijati/tensor'>GitHub</a>")
            onLinkActivated: Qt.openUrlExternally(link)
            horizontalAlignment: Text.Center
            width: parent.width
         }           

         Label {
            text: i18n.tr("Powered by <b>C++, QML</b>")
            horizontalAlignment: Text.Center
            width: parent.width
         }

      }

   }

}
