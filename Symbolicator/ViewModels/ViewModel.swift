//
//  ViewModel.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import Foundation

class ViewModel: ObservableObject {
    let symbols: [Symbol]
    let specialCategories: [Category]
    let regularCategories: [Category]
    let releases: [String: [String: String]]

    init() {
        struct DataModel: Decodable {
            let categories: [Category]
            let symbols: [Symbol]
            let releases: [String: [String: String]]
        }

        let model = Bundle.main.decode(DataModel.self, from: "symbols.json")

        var specialCategories = [Category]()
        var regularCategories = [Category]()

        for category in model.categories {
            if category.isSpecial {
                specialCategories.append(category)
            } else {
                regularCategories.append(category)
            }
        }

        symbols = model.symbols
        releases = model.releases
        self.specialCategories = specialCategories
        self.regularCategories = regularCategories
    }

    func symbols(for category: Category) -> [Symbol] {
        let result = symbols.filter { $0.categories.contains(category.name) }

        if result.isEmpty {
            return symbols
        } else {
            return result
        }
    }

    func iOSVersion(for symbol: Symbol) -> String? {
        if let introductionYear = symbol.availability["base"] {
            if introductionYear != "2019" {
                if let version = releases[introductionYear]?["iOS"] {
                    return "\(version)+"
                }
            }
        }

        return nil
    }

    func results(for search: String) -> [Symbol] {
        let lowercasedSearch = search.lowercased()

        return symbols.filter { symbol in
            if symbol.name.contains(lowercasedSearch) {
                return true
            }

            if let synonyms = symbol.synonyms {
                for synonym in synonyms {
                    if synonym.contains(lowercasedSearch) {
                        return true
                    }
                }
            }

            return false
        }
    }
}
