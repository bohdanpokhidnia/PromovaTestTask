//
//  PromovaTestTaskApp.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct PromovaTestTaskApp: App {
    static var categoryListStore = Store(initialState: CategoriesList.State()) {
        CategoriesList()
    }
    
    var body: some Scene {
        WindowGroup {
            CategoriesListView(store: Self.categoryListStore)
                .updateBackButton(resource: .navigationBackArrow)
                .setupNavigationBar(titleAttributes: [
                    .foregroundColor: UIColor.navigationTitle,
                    .font: UIFont(name: "PTSans-Regular", size: 17) ?? .systemFont(ofSize: 17)
                ])
        }
    }
}
