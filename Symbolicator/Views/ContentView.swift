//
//  ContentView.swift
//  Symbolicator
//
//  Created by Yurii on 10.09.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()

    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                Group {
                    if searchText.isEmpty {
                        List {
                            Section {
                                ForEach(vm.specialCategories) { category in
                                    CategoryRow(category: category)
                                }
                            }

                            Section {
                                ForEach(vm.regularCategories) { category in
                                    CategoryRow(category: category)
                                }
                            }
                        }
                    } else {
                        let category = Category(name: "Results", icon: "magnifyingglass", isSpecial: false)
                        CategoryView(category: category, symbols: vm.results(for: searchText))
                    }
                }
                .navigationTitle("Symbolicator")
                .navigationDestination(for: Category.self) {
                    CategoryView(category: $0, symbols: vm.symbols(for: $0))
                }
            }
            .environmentObject(vm)
            .searchable(text: $searchText)
            .autocorrectionDisabled()

            SettingsView()
                .frame(maxHeight: 220)
                .shadow(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
