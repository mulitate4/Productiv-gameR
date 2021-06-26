import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.12
import QtQuick.Dialogs 1.0

ApplicationWindow {
    visible: true
    title: "Productiv-gameR"
    objectName: "mainWindow"

    property var fontSize: 20;
    property var fixedHeight: 330;
    property var fixedWidth: 500;
    property string timerTime: "00:00:00";

    width: fixedWidth
    height: fixedHeight
    maximumWidth: fixedWidth
    maximumHeight: fixedHeight
    minimumWidth: fixedWidth
    minimumHeight: fixedHeight

    

    Rectangle {
        width: parent.width
        height: parent.height

        color: "black"

        //? Background Image
        Image {
            anchors.fill: parent
            source: "./images/jungle_background.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        //? Filter Rectangle to darken image
        Rectangle {
            id: "filterRect"

            width: parent.width
            height: parent.height

            opacity: 0.6
            color: "black"
        }

        //? Lose input focus
        MouseArea {
            id: "defocusMouseArea"
            anchors.fill: parent
            onClicked: forceActiveFocus()
        }

        //? SPEAK TIME SECTION
        Rectangle {
            id: "speakTimeRectangle"
            height: 50
            width: parent.width - 10

            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 10
            }

            color: "transparent"
            
            border.width: 1
            border.color: "white"
            radius: 3

            CheckBox {
                id: "speakTimeCheckBox"
                objectName: "speakTimeCheckBox"
                text: "Speak the time every quarter hour"

                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }


                contentItem: Text{
                    text: speakTimeCheckBox.text
                    color: "white"
                    font.pixelSize: fontSize

                    anchors.left: speakTimeCheckBox.indicator.right
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                }


                indicator: Rectangle{
                    implicitHeight: 25
                    implicitWidth: 25
                    x: speakTimeCheckBox.anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter

                    radius: 3

                    ColorImage {
                        x: (parent.width - width) / 2
                        y: (parent.height - height) / 2
                        defaultColor: "#353637"
                        color: "black" // Added this
                        source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
                        visible: speakTimeCheckBox.checkState === Qt.Checked
                    }

                }
            }
        }

        //? GAMING TIMER SECTION
        Rectangle {
            id: "timerRectangle"
            height: 150
            width: parent.width - 10

            anchors{
                horizontalCenter: parent.horizontalCenter
                top: speakTimeRectangle.bottom
                topMargin: 10
            }
            
            color: "transparent"
            
            border.width: 1
            border.color: "white"
            radius: 3

            // Start Timer Button
            Button {
                id: "startTimer"
                objectName: "startTimer"
                text: "Start Gaming Timer"

                anchors {
                    top: parent.top
                    topMargin: 15
                    left: parent.left
                    leftMargin: 15
                }

                background: Rectangle {
                    implicitWidth: 220
                    height: 40

                    color: "transparent"
                    border.color: "white"

                    radius: 5
                }

                contentItem: Text {
                    text: startTimer.text
                    color: "white"
                    font.pixelSize: fontSize

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea{
                    id: startTimerMouseArea
                    anchors.fill: parent
                    cursorShape: "PointingHandCursor"
                    onPressed:  mouse.accepted = false
                }
            }

            // Stop Timer Button
            Button {
                id: "stopTimer"
                objectName: "stopTimer"
                text: "Stop and Reset Timer"

                anchors{
                    top: parent.top
                    topMargin: 15
                    right: parent.right
                    rightMargin: 15
                }

                background: Rectangle {
                    implicitWidth: 220
                    height: 40

                    color: "transparent"
                    border.color: "white"

                    radius: 5
                }

                contentItem: Text {
                    text: stopTimer.text
                    color: "white"
                    font.pixelSize: fontSize

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea{
                    id: stopTimerMouseArea
                    height: parent.height
                    width: parent.width
                    cursorShape: "PointingHandCursor"
                    onPressed:  mouse.accepted = false
                }
            }
            
            // Timer Text
            Rectangle {
                color: "transparent"

                anchors{
                    top: startTimer.bottom
                    right: parent.right
                    bottom: parent.bottom
                    left: parent.left
                }

                Text {
                    id: "timerText"
                    objectName: "timerText"

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                    text: timerTime
                    
                    font.pixelSize: 40
                    color: "white"
                }
            }
        }

        //? REMINDERS SECTION
        Rectangle {
            id: "remindersRectangle"
            height: 90
            width: parent.width - 10

            anchors{
                horizontalCenter: parent.horizontalCenter
                top: timerRectangle.bottom
                topMargin: 10
            }

            color: "transparent"
            
            border.width: 1
            border.color: "white"
            radius: 3

            CheckBox {
                text: "Remind me to take a break from Gaming"
                id: "gamingBreakCheckbox"
                objectName: "gamingBreakCheckbox"

                anchors{
                    // verticalCenter: parent.verticalCenter
                    top: parent.top
                    topMargin: 5
                    left: parent.left
                    leftMargin: 5
                }


                contentItem: Text{
                    text: gamingBreakCheckbox.text
                    color: "white"
                    font.pixelSize: fontSize

                    anchors.left: gamingBreakCheckbox.indicator.right
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                }


                indicator: Rectangle{
                    implicitHeight: 25
                    implicitWidth: 25
                    x: gamingBreakCheckbox.anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter

                    radius: 3

                    ColorImage {
                        x: (parent.width - width) / 2
                        y: (parent.height - height) / 2
                        defaultColor: "#353637"
                        color: "black" // Added this
                        source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
                        visible: gamingBreakCheckbox.checkState === Qt.Checked
                    }

                }
            }

            CheckBox {
                text: "Remind me to drink water"
                id: "drinkWaterCheckbox"
                objectName: "drinkWaterCheckbox"

                anchors{
                    // verticalCenter: parent.verticalCenter
                    top: gamingBreakCheckbox.bottom
                    topMargin: 5
                    left: parent.left
                    leftMargin: 5
                }


                contentItem: Text{
                    text: drinkWaterCheckbox.text
                    color: "white"
                    font.pixelSize: fontSize

                    anchors.left: drinkWaterCheckbox.indicator.right
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                }


                indicator: Rectangle{
                    implicitHeight: 25
                    implicitWidth: 25
                    x: drinkWaterCheckbox.anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter

                    radius: 3

                    ColorImage {
                        x: (parent.width - width) / 2
                        y: (parent.height - height) / 2
                        defaultColor: "#353637"
                        color: "black" // Added this
                        source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
                        visible: drinkWaterCheckbox.checkState === Qt.Checked
                    }

                }
            }
        }
    } 
}