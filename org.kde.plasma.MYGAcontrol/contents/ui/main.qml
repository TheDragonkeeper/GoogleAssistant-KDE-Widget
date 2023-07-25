import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
  id: root
  property string commandName: Plasmoid.configuration.commandName
  property string scriptWhite: Plasmoid.configuration.scriptWhite
  property string scriptRed: Plasmoid.configuration.scriptRed
  property string scriptGreen: Plasmoid.configuration.scriptGreen
  property string scriptBlue: Plasmoid.configuration.scriptBlue
  property string scriptlightsOn: Plasmoid.configuration.scriptlightsOn
  property string scriptlightsOff: Plasmoid.configuration.scriptlightsOff
  property string scriptBrightness: Plasmoid.configuration.scriptBrightness

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
  function lightsBrightness() {
      executable.exec(scriptBrightness+i18n("%1%", slider.value*100));
  }
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
                lightsBrightness();
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
