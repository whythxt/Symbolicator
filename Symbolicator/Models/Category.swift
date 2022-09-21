//
//  Category.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import Foundation

struct Category: Decodable, Identifiable, Hashable {
    var id: String { name }
    var name: String
    var icon: String
    var isSpecial: Bool

    static let example = Category(name: "Health", icon: "heart", isSpecial: false)
}
