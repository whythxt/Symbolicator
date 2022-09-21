//
//  Symbol.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import Foundation

struct Symbol: Decodable, Identifiable, Hashable {
    var id: String { name }
    var name: String
    var categories: [String]
    var synonyms: [String]?
    var availability: [String: String]
    var restrictions: String?

    static let example = Symbol(name: "pill.circle", categories: ["Health"], availability: ["base": "2021"])
}
