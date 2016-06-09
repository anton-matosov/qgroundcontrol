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
    ///         min:            0  ///< Optional, can use value from Fact created for 'param'. Value from Fact has precedence
    ///         max:            100 ///< Optional, can use value from Fact created for 'param'. Value from Fact has precedence
    ///         step:           1 ///< Optional, can use value from Fact created for 'param'. Value from Fact has precedence
    ///     }
    property ListModel steppersModel

    FactPanelController { id: controller; factPanel: panel }

    QGCPalette { id: palette; colorGroupEnabled: enabled }
    property real _margins: ScreenTools.defaultFontPixelHeight

    property bool _loadComplete: false

    Component.onCompleted: {
//        var labelWidth = 0
//        for (var i = 0; i < steppersModel.count; i++) {
//            labelWidth = Math.max(labelWidth, stepperRepeater.itemAt(i).labelWidth)
//        }
//        for (i = 0; i < steppersModel.count; i++) {
//            stepperRepeater.itemAt(i).labelLayoutWidth = labelWidth
//        }

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
                spacing:            _margins

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
                        height:             cellColumn.height + _margins * 2
                        color:              palette.windowShade

                        property Fact fact: controller.getParameterFact(-1, param)

                        ColumnLayout {
                            id: cellColumn
                            spacing: _margins
                            anchors.margins:    _margins
                            anchors.left:       parent.left
                            anchors.right:      parent.right
                            anchors.top:        parent.top

                            property alias labelWidth: nameLabel.width

                            RowLayout {
                                id: stepperRow
                                spacing: _margins
//                                anchors.margins:    _margins
//                                anchors.top:        stepperRect.top
                                anchors.left:       parent.left
//                                anchors.right:      parent.right

                                QGCLabel {
                                    id: nameLabel
                                    text:           (title && !title.isEmpty) ? title : fact.shortDescription
                                    wrapMode:       Text.WordWrap
                                    horizontalAlignment: Text.AlignRight
                                    verticalAlignment: Text.AlignVCenter

                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                }

                                FactStepper {
                                    id: stepper

                                    fact: stepperRect.fact
                                }

                                QGCButton {
                                    id: _tooltipButton

                                    text:     "?"
                                    tooltip:  fact.longDescription

                                    onClicked: {
                                        descriptionLabel.visible = !descriptionLabel.visible
                                    }
                                }
                            }

                            QGCLabel {
                                id: descriptionLabel

                                Layout.fillWidth: true

                                visible:        false
                                text:           fact.longDescription
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
