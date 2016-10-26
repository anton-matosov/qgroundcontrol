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
import QtQuick.Layouts      1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls.Private 1.0

import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Palette       1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0

QGCView {
    viewPanel: panel

    property string panelTitle: "Title" ///< Title for group

    /// ListModel must contains elements which look like this:
    ///     ListElement {
    ///         title:          "Roll sensitivity"
    ///         param:          "MC_ROLL_TC"
    ///     }
    property ListModel steppersModel

    FactPanelController { id: controller; factPanel: panel }

    QGCPalette { id: palette; colorGroupEnabled: enabled }
    property real _margins: ScreenTools.defaultFontPixelHeight
    property real _thinMargins: ScreenTools.smallFontPointSize

    property bool _loadComplete: false

    Component.onCompleted: {
        _loadComplete = true
    }

    QGCViewPanel {
        id:             panel
        anchors.fill:   parent

        QGCFlickable {
            clip:               true
            anchors.fill:       parent
            contentHeight:      outerColumn.y + outerColumn.height
            flickableDirection: Flickable.VerticalFlick

            Column {
                id:                 outerColumn
                anchors.margins:    _margins
                anchors.left:       parent.left
                anchors.right:      parent.right
                spacing:            2

                QGCLabel {
                    id:             panelLabel
                    text:           panelTitle
                    font.family:    ScreenTools.demiboldFontFamily
                }

                Repeater {
                    id:     stepperRepeater
                    model:  steppersModel

                    anchors.left:       parent.left
                    anchors.right:      parent.right

                    Rectangle {
                        id:                 stepperRect
                        anchors.left:       parent.left
                        anchors.right:      parent.right
                        height:             cellColumn.height + _thinMargins * 2
                        color:              palette.windowShade

                        property Fact fact

                        Component.onCompleted: {
                            if (param) {
                                fact = controller.getParameterFact(-1, param)
                            }
                        }

                        ColumnLayout {
                            id:                 cellColumn
                            spacing:            _thinMargins
                            anchors.margins:    _thinMargins
                            anchors.left:       parent.left
                            anchors.right:      parent.right
                            anchors.top:        parent.top

                            property alias labelWidth: nameLabel.width

                            RowLayout {
                                id:             stepperRow
                                spacing:        _margins
                                anchors.left:   parent.left

                                QGCLabel {
                                    id:                     nameLabel
                                    text:                   (title && !title.isEmpty) ? title : fact.shortDescription
                                    wrapMode:               Text.WordWrap
                                    horizontalAlignment:    Text.AlignRight
                                    verticalAlignment:      Text.AlignVCenter

                                    Layout.minimumWidth: 80
                                    Layout.maximumWidth: 80
                                }

                                FactStepper {
                                    id: stepper
                                    visible: fact

                                    fact: stepperRect.fact
                                }

                                QGCButton {
                                    id:         _tooltipButton
                                    visible:    fact

                                    text:       "?"
                                    tooltip:    fact ? fact.longDescription : ""

                                    onClicked: {
                                        descriptionLabel.visible = !descriptionLabel.visible
                                    }
                                }
                            }

                            QGCLabel {
                                id: descriptionLabel

                                Layout.fillWidth: true

                                visible:        false
                                text:           fact ? fact.longDescription : ""
                                wrapMode:       Text.WordWrap
                                horizontalAlignment: Text.AlignLeft
                            }
                        }
                    }
                }

            }
        }
    }

} // QGCView
