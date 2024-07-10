//
//  CategoriesLoaderLive.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation
import ComposableArchitecture

extension CategoriesLoader: DependencyKey {
    static var liveValue = CategoriesLoader(fetchCategories: {
        @Dependency(\.config) var config
        @Dependency(\.requestBuilder) var requestBuilder
        
        guard let apiURL = URL(string: config.apiURL) else {
            return .failure(NSError(domain: "", code: 0))
        }
        let request = requestBuilder
            .setHTTPMethod(.get)
            .buildRequest(baseURL: apiURL)
        guard let url = request?.url else {
            return .failure(NSError(domain: "", code: 0))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categories = try JSONDecoder().decode([Category].self, from: data)
            return .success(categories)
        } catch {
            return .failure(NSError(domain: "", code: 0))
        }
    })
}

extension DependencyValues {
    var categoriesLoader: CategoriesLoader {
        get { self[CategoriesLoader.self] }
        set { self[CategoriesLoader.self] = newValue }
    }
}
