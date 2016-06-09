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

///////////////////////////////////////////////////////////////
        ListElement {
            title:          qsTr("Roll P")
            param:          "MC_ROLL_P"
        }

        ListElement {
            title:          qsTr("Roll Rate P")
            param:          "MC_ROLLRATE_P"
        }

        ListElement {
            title:          qsTr("Roll Rate I")
            param:          "MC_ROLLRATE_I"
        }

        ListElement {
            title:          qsTr("Roll Rate D")
            param:          "MC_ROLLRATE_D"
        }

        ListElement {
            param:          "MC_ROLLRATE_FF"
        }

///////////////////////////////////////////////////////////////

        ListElement {
            title:          qsTr("Pitch P")
            param:          "MC_PITCH_P"
        }

        ListElement {
            title:          qsTr("Pitch Rate P")
            param:          "MC_PITCHRATE_P"
        }

        ListElement {
            title:          qsTr("Pitch Rate I")
            param:          "MC_PITCHRATE_I"
        }

        ListElement {
            title:          qsTr("Pitch Rate D")
            param:          "MC_PITCHRATE_D"
        }

        ListElement {
            param:          "MC_PITCHRATE_FF"
        }

///////////////////////////////////////////////////////////////

        ListElement {
            title:          qsTr("Yaw P")
            param:          "MC_YAW_P"
        }

        ListElement {
            param:          "MC_YAW_FF"
        }

        ListElement {
            title:          qsTr("Yaw Rate P")
            param:          "MC_YAWRATE_P"
        }

        ListElement {
            title:          qsTr("Yaw Rate I")
            param:          "MC_YAWRATE_I"
        }

        ListElement {
            title:          qsTr("Yaw Rate D")
            param:          "MC_YAWRATE_D"
        }

        ListElement {
            param:          "MC_YAWRATE_FF"
        }
    }
}
