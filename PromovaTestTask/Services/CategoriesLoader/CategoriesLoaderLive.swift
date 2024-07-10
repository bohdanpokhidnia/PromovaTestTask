//
//  CategoriesLoaderLive.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation
import ComposableArchitecture

extension CategoriesLoader: DependencyKey {
    static var liveValue = CategoriesLoader(
        fetchCategories: { (categoriesLoaderDependencies) in
            @Dependency(\.config) var config
            @Dependency(\.requestBuilder) var requestBuilder
            
            guard let apiURL = URL(string: config.apiURL) else {
                return .failure(.invalidURL)
            }
            
            let request = requestBuilder
                .setHTTPMethod(.get)
                .buildRequest(baseURL: apiURL)
            
            guard let url = request?.url else {
                return .failure(.invalidRequestURL)
            }
            
            let loadDataResult = await categoriesLoaderDependencies.loadData(url)
            
            switch loadDataResult {
            case let .success(data):
                let decodeDataResult = categoriesLoaderDependencies.decode(data, JSONDecoder())
                
                switch decodeDataResult {
                case let .success(categories):
                    return .success(categories)
                    
                case let .failure(error):
                    return .failure(error)
                }
                
            case let .failure(error):
                return .failure(error)
            }
        }
    )
}

extension DependencyValues {
    var categoriesLoader: CategoriesLoader {
        get { self[CategoriesLoader.self] }
        set { self[CategoriesLoader.self] = newValue }
    }
}
