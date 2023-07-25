import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.1 as PlasmaCore
import org.kde.plasma.components 3.0 as PC3
import org.kde.kquickcontrolsaddons 2.0 as KQCAddons
import org.kde.plasma.private.volume 0.1

import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras


Item {
  id: root
  property string commandName: Plasmoid.configuration.commandName
  property string scriptWhite: Plasmoid.configuration.scriptWhite
  property string scriptRed: Plasmoid.configuration.scriptRed
  property string scriptGreen: Plasmoid.configuration.scriptGreen
  property string scriptBlue: Plasmoid.configuration.scriptBlue
  property string scriptlightsOn:  Plasmoid.configuration.scriptlightsOn
  property string scriptlightsOff: Plasmoid.configuration.scriptlightsOff
  property string scriptBrightness: Plasmoid.configuration.scriptBrightness

  property string plug1name: Plasmoid.configuration.plug1name
  property string scriptplug1: Plasmoid.configuration.scriptplug1
  property string scriptplug1x: Plasmoid.configuration.scriptplug1x
  property string plug2name: Plasmoid.configuration.plug2name
  property string scriptplug2: Plasmoid.configuration.scriptplug2
  property string scriptplug2x: Plasmoid.configuration.scriptplug2x
  property string plug3name: Plasmoid.configuration.plug3name
  property string scriptplug3: Plasmoid.configuration.scriptplug3
  property string scriptplug3x: Plasmoid.configuration.scriptplug3x
  property string plug4name: Plasmoid.configuration.plug4name
  property string scriptplug4: Plasmoid.configuration.scriptplug4
  property string scriptplug4x: Plasmoid.configuration.scriptplug4x

  property string killassistant: Plasmoid.configuration.killassistant

  PlasmaCore.DataSource {
      id: executable
      engine: "executable"
      connectedSources: []

      function exec(cmd) {
          connectSource(cmd)
      }
  }

  function setWhite() {
      executable.exec(scriptWhite);
  }
  function setRed() {
      executable.exec(scriptRed);
  }
  function setGreen() {
      executable.exec(scriptGreen);
  }
  function setBlue() {
      executable.exec(scriptBlue);
  }
  function lightsOn() {
      executable.exec(scriptlightsOn);
  }
  function lightsOff() {
      executable.exec(scriptlightsOff);
  }
  function lightsBrightness(brightnessslider) {
      executable.exec( scriptBrightness+i18n("%1%", brightnessslider*100) );
  }

  function plug1on() {
      executable.exec(scriptplug1);
  }
  function plug1off() {
      executable.exec(scriptplug1x);
  }
  function plug2on() {
      executable.exec(scriptplug2);
  }
  function plug2off() {
      executable.exec(scriptplug2x);
  }
  function plug3on() {
      executable.exec(scriptplug3);
  }
  function plug3off() {
      executable.exec(scriptplug3x);
  }
  function plug4on() {
      executable.exec(scriptplug4);
  }
  function plug4off() {
      executable.exec(scriptplug4x);
  }
  function killmyass() {
      executable.exec(killassistant);
    }



  Plasmoid.fullRepresentation: PlasmaExtras.Representation {
    id: fullRep

    collapseMarginsHint: true

    KeyNavigation.down: tabBar.currentItem

    header: PlasmaExtras.PlasmoidHeading {
        // Make this toolbar's buttons align vertically with the ones above
        rightPadding: -PlasmaCore.Units.devicePixelRatio
        // Allow tabbar to touch the header's bottom border
        bottomPadding: -bottomInset


    RowLayout {
        anchors.fill: parent

        PC3.TabBar {
            id: tabBar
            Layout.fillWidth: true
            Layout.fillHeight: true

            currentIndex: {
                switch (plasmoid.configuration.currentTab) {
                case "lights":
                    return lightsTab.PC3.TabBar.index;
                case "plugs":
                    return plugsTab.PC3.TabBar.index;
                case "comms":
                    return commandsTab.PC3.TabBar.index;
                default:
                    return lightsTab.PC3.TabBar.index;
                }
            }

            KeyNavigation.down: contentView.currentItem.contentItem.upperListView.itemAtIndex(0)


            onCurrentIndexChanged: {
                switch (currentIndex) {
                case lightsTab.PC3.TabBar.index:
                    plasmoid.configuration.currentTab = "lights";
                    break;
                case plugsTab.PC3.TabBar.index:
                    plasmoid.configuration.currentTab = "plugs";
                    break;
                case commandsTab.PC3.TabBar.index:
                    plasmoid.configuration.currentTab = "comms";
                    break;
                }
            }

            PC3.TabButton {
                id: lightsTab
                text: i18n("Lights")

                KeyNavigation.up: fullRep.KeyNavigation.up
            }

            PC3.TabButton {
                id: plugsTab
                text: i18n("Plugs")

                KeyNavigation.up: fullRep.KeyNavigation.up
            }
            PC3.TabButton {
                id: commandsTab
                text: i18n("Commands")

                KeyNavigation.up: fullRep.KeyNavigation.up
            }
        }
    }
  }
  contentItem: StackView {
        id: contentView
        TwoPartView {
            id: lightsView
            ColumnLayout {
              RowLayout {

                PlasmaComponents.Label {
                      Layout.alignment: Qt.AlignRight
                      text: i18n("Brightness")
                  }
                  PlasmaComponents.Slider {
                      id: slider
                      Layout.fillWidth: true
                      minimumValue: 0
                      maximumValue: 1
                      stepSize: 0.01
                  }
                  PlasmaComponents.Label {
                      id: sliderValueLabel
                      Layout.minimumWidth: textMetrics.width
                      text: formatText(slider.value)
                      function formatText(value) {
                          return i18n("%1%", Math.round(value * 100))
                      }
                      TextMetrics {
                          id: textMetrics
                          font.family: sliderValueLabel.font.family
                          font.pointSize: sliderValueLabel.font.pointSize
                          text: sliderValueLabel.formatText(slider.maximumValue)
                      }
                  }

              }
              RowLayout {
                  PlasmaComponents.Button {
                      id: setbrightness
                      iconSource: "view-refresh"
                      text: i18n("Set")
                      onClicked: {
                          lightsBrightness(slider.value);
                          }
                  }
              }
              RowLayout {
                PlasmaComponents.Button {
                  id: lightsoff
                  iconSource: "view-refresh"
                  text: i18n("Lights Off")
                  onClicked: {
                      lightsOff();
                      }
                  }
                PlasmaComponents.Button {
                  id: lightson
                  iconSource: "view-refresh"
                  text: i18n("Lights On")
                  onClicked: {
                      lightsOn();
                      }
                  }
                PlasmaComponents.Button {
                  id: lightsred
                  iconSource: "view-refresh"
                  text: i18n("Red")
                  onClicked: {
                      setRed();
                      }
                  }
                PlasmaComponents.Button {
                  id: lightsgree
                  iconSource: "view-refresh"
                  text: i18n("Green")
                  onClicked: {
                      setGreen();
                      }
                  }
                PlasmaComponents.Button {
                  id: lightsblue
                  iconSource: "view-refresh"
                  text: i18n("Blue")
                  onClicked: {
                      setBlue();
                      }
                  }
                PlasmaComponents.Button {
                  id: lightswhite
                  iconSource: "view-refresh"
                  text: i18n("White")
                  onClicked: {
                      setWhite();
                      }
                  }

              }
            }
        }
        TwoPartView {
            id: plugsView

            ColumnLayout{
            RowLayout {
              PlasmaComponents.Label {
                    Layout.alignment: Qt.AlignRight
                    text: plug1name
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("On")
                    onClicked: {
                        plug1on();
                        }
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("Off")
                    onClicked: {
                        plug1off();
                        }
                }
            }
            RowLayout {
              PlasmaComponents.Label {
                    Layout.alignment: Qt.AlignRight
                    text: plug2name
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("On")
                    onClicked: {
                        plug2on();
                        }
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("Off")
                    onClicked: {
                        plug2off();
                        }
                }
            }
            RowLayout {
              PlasmaComponents.Label {
                    Layout.alignment: Qt.AlignRight
                    text: plug3name
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("On")
                    onClicked: {
                        plug3on();
                        }
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("Off")
                    onClicked: {
                        plug3off();
                        }
                }
            }
            RowLayout {
              PlasmaComponents.Label {
                    Layout.alignment: Qt.AlignRight
                    text: plug4name
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("On")
                    onClicked: {
                        plug4on();
                        }
                }
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("Off")
                    onClicked: {
                        plug4off();
                        }
                }
            }
            }
        }
        TwoPartView {
            id: commsView
            ColumnLayout{
            RowLayout {
                PlasmaComponents.Button {
                    iconSource: "view-refresh"
                    text: i18n("Kill assistant")
                    onClicked: {
                        killmyass();
                        }
                }
              }}
        }
        Connections {
            target: tabBar
            function onCurrentIndexChanged() {
                if (tabBar.currentItem === lightsTab) {
                    //contentView.reverseTransitions = false
                    contentView.replace(lightsView)
                } else if (tabBar.currentItem === plugsTab) {
                    //contentView.reverseTransitions = true
                    contentView.replace(plugsView)
                } else if (tabBar.currentItem === commandsTab) {
                    //contentView.reverseTransitions = true
                    contentView.replace(commsView)
                }
            }
        }
    }
    component TwoPartView : PC3.ScrollView {
       id: scrollView
       PC3.ScrollBar.horizontal.policy: PC3.ScrollBar.AlwaysOff

       Loader {
           parent: scrollView
           anchors.centerIn: parent
           width: parent.width -  PlasmaCore.Units.gridUnit * 4
           active: visible

       }
       contentItem: Flickable {
           contentHeight: layout.implicitHeight

           property ListView upperListView: upperSection.visible ? upperSection : lowerSection
           property ListView lowerListView: lowerSection.visible ? lowerSection : upperSection

           ColumnLayout {
               id: layout
               width: parent.width
               spacing: 0
               ListView {
                   id: upperSection
                   visible: count && !contentView.hiddenTypes.includes(scrollView.upperType)
                   interactive: false
                   Layout.fillWidth: true
                   implicitHeight: contentHeight
                   model: scrollView.upperModel
                   focus: visible

                   Keys.onDownPressed: {
                       if (currentIndex < count - 1) {
                           incrementCurrentIndex();
                           currentItem.forceActiveFocus();
                       } else if (lowerSection.visible) {
                           lowerSection.currentIndex = 0;
                           lowerSection.currentItem.forceActiveFocus();
                       } else {
                           raiseMaximumVolumeCheckbox.forceActiveFocus(Qt.TabFocusReason);
                       }
                       event.accepted = true;
                   }
                   Keys.onUpPressed: {
                       if (currentIndex > 0) {
                           decrementCurrentIndex();
                           currentItem.forceActiveFocus();
                       } else {
                           tabBar.currentItem.forceActiveFocus(Qt.BacktabFocusReason);
                       }
                       event.accepted = true;
                   }
               }
               ListView {
                   id: lowerSection
                   visible: count && !contentView.hiddenTypes.includes(scrollView.lowerType)
                   interactive: false
                   Layout.fillWidth: true
                   implicitHeight: contentHeight
                   model: scrollView.lowerModel
                   focus: visible && !upperSection.visible

                   Keys.onDownPressed: {
                       if (currentIndex < count - 1) {
                           incrementCurrentIndex();
                           currentItem.forceActiveFocus();
                       } else {
                           raiseMaximumVolumeCheckbox.forceActiveFocus(Qt.TabFocusReason);
                       }
                       event.accepted = true;
                   }
                   Keys.onUpPressed: {
                       if (currentIndex > 0) {
                           decrementCurrentIndex();
                           currentItem.forceActiveFocus();
                       } else if (upperSection.visible) {
                           upperSection.currentIndex = upperSection.count - 1;
                           upperSection.currentItem.forceActiveFocus();
                       } else {
                           tabBar.currentItem.forceActiveFocus(Qt.BacktabFocusReason);
                       }
                       event.accepted = true;
                   }
               }
           }
       }
   }

   Component.onCompleted: {
    contentView.replace(lightsView)
   }
}
}
