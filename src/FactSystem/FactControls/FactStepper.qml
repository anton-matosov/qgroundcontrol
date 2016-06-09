import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import QGroundControl.FactSystem 1.0
import QGroundControl.Palette 1.0
import QGroundControl.Controls 1.0

Item {
    property bool enabled: true
    property alias fact: factInput.fact

    property double minimumValue:       isNaN(fact.min) ? 0 : fact.min
    property double maximumValue:       isNaN(fact.max) ? 1 : fact.max
    property double stepSize:           isNaN(fact.increment) ? 0 : fact.increment
    property double stepRatio:          0.1

    implicitWidth: 160
    implicitHeight: 34

    function incrementWithScale(multiplier) {
        var step = stepSize;
        if (step == 0) {
            step = Math.abs(stepRatio * fact.value);
        }

        var newValue = fact.value + (step * multiplier);

        if (newValue < fact.min) {
            newValue = fact.min;
        }
        if (newValue > fact.max) {
            newValue = fact.max;
        }

        fact.value = newValue;
        factInput.text = fact.valueString
    }

    Row {
        anchors.fill:   parent

        QGCButton {
            id: minusButton
            width : parent.width / 4
            height: parent.height
            text: "-"
            enabled: fact.value > fact.min

            onClicked: {
                incrementWithScale(-1)
            }
        }

        FactTextField {
            width : parent.width / 2
            height: parent.height

            horizontalAlignment: TextInput.AlignHCenter
            id:             factInput
        }

        QGCButton {
            id: plusButton
            width : parent.width / 4
            height: parent.height
            text: "+"
            enabled: fact.value < fact.max

            onClicked: {
                incrementWithScale(1);
            }
        }
    }
}
