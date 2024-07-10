//
//  CategoriesList.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CategoriesList {
    @ObservableState
    struct State {
        var factFeature = FactFeature.State()
        var categories: IdentifiedArrayOf<Category> = []
    }
    
    enum Action {
        case onAppear
        case categoriesResponse([Category])
        case factFeature(FactFeature.Action)
    }
    
    @Dependency(\.categoriesLoader) private var categoriesLoader
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .onAppear:
                guard state.categories.isEmpty else {
                    return .none
                }
                state.categories.removeAll()
                
                return .run { (send) in
                    let result = await categoriesLoader.fetchCategories(CategoryLoaderDependencies())
                    switch result {
                    case let .success(categories):
                        await send(.categoriesResponse(categories))
                        
                    case let .failure(error):
                        print("[dev] \(error)")
                    }
                }
                
            case let .categoriesResponse(categories):
                let sortedCategories = categories.sorted(by: { $0.order < $1.order })
                state.categories = IdentifiedArray(uniqueElements: sortedCategories)
                return .none
                
            case .factFeature:
                return .none
            }
        }
    }
}
