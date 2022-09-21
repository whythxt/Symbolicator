//
//  SymbolView.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import SwiftUI

struct SymbolView: View {
    @EnvironmentObject var vm: ViewModel

    let symbol: Symbol
    var showRestrictionsAction: () -> Void

    @AppStorage("weight") var weight = "Regular"
    @AppStorage("rendering") var rendering = "Monochrome"
    @AppStorage("variableValue") var variableValue = 1.0

    @AppStorage("color1") var color1: Color = .black
    @AppStorage("color2") var color2: Color = .blue
    @AppStorage("color3") var color3: Color = .mint

    var body: some View {
        VStack {
            Image(systemName: symbol.name, variableValue: variableValue)
                .font(.system(size: 72))
                .frame(width: 150, height: 150)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(rendering == "Automatic" ? .primary : color1, color2, color3)
                .fontWeight(fontWeight)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.quaternary))
                .overlay(alignment: .bottomLeading) {
                    if let version = vm.iOSVersion(for: symbol) {
                        Text(version)
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .padding(5)
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    if symbol.restrictions != nil {
                        Button(action: showRestrictionsAction) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.secondary)
                                .padding(5)
                        }
                        .buttonStyle(.plain)
                    }
                }

            Text(symbol.name)
                .multilineTextAlignment(.center)
                .lineLimit(2...2)
        }
        .padding()
        .contentShape(Rectangle())
        .accessibilityElement()
        .accessibilityLabel(symbol.name)
        .accessibilityHint(hint)
        .contextMenu {
            Button {
                UIPasteboard.general.string = symbol.name
            } label: {
                Label("Copy name", systemImage: "doc.on.doc")
            }
        }
    }

    var renderingMode: SymbolRenderingMode {
        switch rendering {
        case "Hierarchical":
            return .hierarchical
        case "Multicolor":
            return .multicolor
        case "Palette":
            return .palette
        default:
            return .monochrome
        }
    }

    var fontWeight: Font.Weight {
        switch weight {
        case "Ultra Light": return .ultraLight
        case "Thin": return .thin
        case "Light": return .light
        case "Medium": return .medium
        case "Semibold": return .semibold
        case "Bold": return .bold
        case "Heavy": return .heavy
        case "Black": return .black
        default: return .regular
        }
    }

    var hint: String {
        var result = ""

        if let version = vm.iOSVersion(for: symbol) {
            result += "\(version)."
        } else {
            result += "iOS 13.0+."
        }

        if let restrictions = symbol.restrictions {
            result += " \(restrictions)"
        }

        return result
    }
}

struct SymbolView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolView(symbol: .example) { }
    }
}
