//
//  CategoryRow.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import SwiftUI

struct CategoryRow: View {
    let category: Category

    var body: some View {
        NavigationLink(value: category) {
            Label(category.name, systemImage: category.icon)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: .example)
    }
}
