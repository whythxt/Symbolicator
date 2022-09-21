//
//  Color-RawRepresentable.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import SwiftUI

extension Color: RawRepresentable {
    public init(rawValue: String) {
        if let data = Data(base64Encoded: rawValue) {
            if let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
                self = Color(uiColor: color)
                return
            }
        }

        self = .black
    }

    public var rawValue: String {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false).base64EncodedString()
        } catch {
            return ""
        }
    }
}
