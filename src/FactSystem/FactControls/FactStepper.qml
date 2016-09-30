import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs         1.2

import QGroundControl.ScreenTools   1.0
import QGroundControl.FactSystem 1.0
import QGroundControl.Palette 1.0
import QGroundControl.Controls 1.0

Item {
    property bool enabled: true
    property alias fact: factInput.fact

    property string valueText:          fact ? fact.valueString : ""
    property double factValue:          Number(valueText)

    property double minimumValue:       !fact || isNaN(fact.min) ? 0 : fact.min
    property double maximumValue:       !fact || isNaN(fact.max) ? 1 : fact.max
    property double stepSize:           !fact || isNaN(fact.increment) ? 0 : fact.increment
    property double stepRatio:          0.1

    implicitWidth: 160
    implicitHeight: 34

    function incrementWithScale(multiplier) {
        var step = stepSize;
        if (step == 0) {
            step = Math.abs(stepRatio * factValue);
        }

        setFactValue(factValue + (step * multiplier));
    }

    function setFactValue(newValue) {
        if (newValue < fact.min) {
            newValue = fact.min;
        }
        if (newValue > fact.max) {
            newValue = fact.max;
        }

        factValueChangeDelay.stop()
        valueText = newValue.toLocaleString(Qt.locale(), 'f', fact.decimalPlaces)
        factValueChangeDelay.start()
    }

    Timer {
        id: factValueChangeDelay

        interval: 350
        repeat: false
        running: false

        onTriggered: {
            console.log("New value: ", factValue)
            fact.value = factValue;
            fact.valueChanged(fact.value)
        }
    }

    Row {
        anchors.fill:   parent

        QGCButton {
            id: minusButton
            width : parent.width / 4
            height: parent.height
            text: "-"
            enabled: fact ? (factValue > fact.min) : false

            onClicked: {
                incrementWithScale(-1)
            }
        }

        QGCTextField {
            id: factInput
            width : parent.width / 2
            height: parent.height

            horizontalAlignment: TextInput.AlignHCenter

            text:       valueText
            unitsLabel: fact ? fact.units : ""
            showUnits:  true

            property Fact   fact:           null
            property string _validateString

            // At this point all Facts are numeric
            validator:          DoubleValidator {}
            inputMethodHints:   ScreenTools.isiOS ?
                                    Qt.ImhNone :                // iOS numeric keyboard has not done button, we can't use it
                                    Qt.ImhFormattedNumbersOnly  // Forces use of virtual numeric keyboard

            onEditingFinished: {
//                if (typeof qgcView !== 'undefined' && qgcView) {
//                    var errorString = fact.validate(text, false /* convertOnly */)
//                    if (errorString == "") {
//                        fact.value = text
//                    } else {
//                        _validateString = text
//                        qgcView.showDialog(editorDialogComponent, qsTr("Invalid Parameter Value"), qgcView.showDialogDefaultWidth, StandardButton.Save)
//                    }
//                } else {
//                    fact.value = text
//                    fact.valueChanged(fact.value)
//                }
                setFactValue(text);
            }
        }

        QGCButton {
            id: plusButton
            width : parent.width / 4
            height: parent.height
            text: "+"
            enabled: fact ? (factValue < fact.max) : false

            onClicked: {
                incrementWithScale(1);
            }
        }
    }
}
