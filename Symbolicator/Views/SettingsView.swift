//
//  SettingsView.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("rendering") var rendering = "Automatic"
    @AppStorage("weight") var weight = "Regular"
    @AppStorage("variableValue") var variableValue = 1.0

    @AppStorage("color1") var color1: Color = .black
    @AppStorage("color2") var color2: Color = .blue
    @AppStorage("color3") var color3: Color = .mint

    let renderingModes = ["Automatic", "Hierarchical", "Monochrome", "Multicolor", "Palette"]
    let weights = ["Ultra Light", "Thin", "Light", "Regular", "Medium", "Semibold", "Bold", "Heavy", "Black"]

    var body: some View {
        Form {
            Picker("Weight", selection: $weight) {
                ForEach(weights, id: \.self, content: Text.init)
            }

            Picker("Rendering mode", selection: $rendering) {
                ForEach(renderingModes, id: \.self, content: Text.init)
            }

            if rendering != "Automatic" {
                LabeledContent("Colors") {
                    HStack {
                        ColorPicker("Primary color", selection: $color1)

                        if rendering == "Palette" {
                            ColorPicker("Secondary color", selection: $color2)
                            ColorPicker("Tertiary color", selection: $color3)
                        }
                    }
                    .labelsHidden()
                }
            }

            LabeledContent("Variability") {
                Slider(value: $variableValue) {
                    Text("Variable amount")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
