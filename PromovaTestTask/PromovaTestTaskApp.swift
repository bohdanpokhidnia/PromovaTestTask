//
//  PromovaTestTaskApp.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI

@main
struct PromovaTestTaskApp: App {
    var body: some Scene {
        WindowGroup {
            CategoriesListView()
                .updateBackButton(resource: .navigationBackArrow)
                .setupNavigationBar(titleAttributes: [
                    .foregroundColor: UIColor.navigationTitle,
                    .font: UIFont(name: "PTSans-Regular", size: 17) ?? .systemFont(ofSize: 17)
                ])
        }
    }
}
