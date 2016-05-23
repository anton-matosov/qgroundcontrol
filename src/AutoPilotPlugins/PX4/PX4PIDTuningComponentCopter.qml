/*=====================================================================

 QGroundControl Open Source Ground Control Station

 (c) 2009 - 2015 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>

 This file is part of the QGROUNDCONTROL project

 QGROUNDCONTROL is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 QGROUNDCONTROL is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with QGROUNDCONTROL. If not, see <http://www.gnu.org/licenses/>.

 ======================================================================*/

import QtQuick              2.5
import QtQuick.Controls     1.4

import QGroundControl.Controls  1.0

FactStepperGroup {
    anchors.fill: parent
    panelTitle:     "PID Tuning"

    steppersModel: ListModel {
        // PID Tuning
        ListElement {
            title:          qsTr("MC_ROLL_P")
            description:    qsTr("")
            param:          "MC_ROLL_P"
            min:            0.
            max:            10.
            step:           0.01
        }

        ListElement {
            title:          qsTr("MC_PITCH_P")
            description:    qsTr("")
            param:          "MC_PITCH_P"
            min:            0.
            max:            10.
            step:           0.01
        }

        ListElement {
            title:          qsTr("MC_YAW_P")
            description:    qsTr("")
            param:          "MC_YAW_P"
            min:            0.
            max:            10.
            step:           0.01
        }

        ListElement {
            title:          qsTr("MC_ROLLRATE_P")
            description:    qsTr("")
            param:          "MC_ROLLRATE_P"
            min:            0
            max:            0.3
            step:           0.005
        }

        ListElement {
            title:          qsTr("MC_PITCHRATE_P")
            description:    qsTr("")
            param:          "MC_PITCHRATE_P"
            min:            0
            max:            0.3
            step:           0.005
        }

        ListElement {
            title:          qsTr("MC_ROLLRATE_I")
            description:    qsTr("")
            param:          "MC_ROLLRATE_I"
            min:            0
            max:            0.3
            step:           0.005
        }

        ListElement {
            title:          qsTr("MC_PITCHRATE_I")
            description:    qsTr("")
            param:          "MC_PITCHRATE_I"
            min:            0
            max:            0.3
            step:           0.005
        }

        ListElement {
            title:          qsTr("MC_ROLLRATE_D")
            description:    qsTr("")
            param:          "MC_ROLLRATE_D"
            min:            0
            max:            0.01
            step:           0.0001
        }

        ListElement {
            title:          qsTr("MC_PITCHRATE_D")
            description:    qsTr("")
            param:          "MC_PITCHRATE_D"
            min:            0
            max:            0.01
            step:           0.0001
        }


        ListElement {
            title:          qsTr("MC_YAWRATE_P")
            description:    qsTr("")
            param:          "MC_YAWRATE_P"
            min:            0
            max:            0.3
            step:           0.01
        }

        ListElement {
            title:          qsTr("MC_YAWRATE_I")
            description:    qsTr("")
            param:          "MC_YAWRATE_I"
            min:            0
            max:            0.3
            step:           0.005
        }

        ListElement {
            title:          qsTr("MC_YAWRATE_D")
            description:    qsTr("")
            param:          "MC_YAWRATE_D"
            min:            0
            max:            0.01
            step:           0.0001
        }
    }
}
