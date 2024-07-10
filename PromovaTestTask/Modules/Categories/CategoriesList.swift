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
        var isLoading: Bool = false
        var categories: IdentifiedArrayOf<Category> = []
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case onAppear
        case categoriesResponse([Category])
        case network(error: NetworkError)
        case categoryViewTapped(Category)
        case check(CategoryStatus)
        case path(StackActionOf<Path>)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case fact(FactFeature)
    }
    
    @Dependency(\.categoriesLoader) private var categoriesLoader
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .onAppear:
                guard state.categories.isEmpty else {
                    return .none
                }
                state.isLoading = true
                state.categories.removeAll()
                
                return .run { (send) in
                    let result = await categoriesLoader.fetchCategories(CategoryLoaderDependencies())
                    switch result {
                    case let .success(categories):
                        await send(.categoriesResponse(categories))
                        
                    case let .failure(error):
                        await send(.network(error: error))
                    }
                }
                
            case let .categoriesResponse(categories):
                let sortedCategories = categories.sorted(by: { $0.order < $1.order })
                state.isLoading = false
                state.categories = IdentifiedArray(uniqueElements: sortedCategories)
                return .none
                
            case let .network(error):
                state.isLoading = false
                print("[dev] \(error.localizedDescription)")
                return .none
                
            case let .categoryViewTapped(category):
                return .send(.check(category.status))
                
            case let .check(status):
                switch status {
                case .free:
                    state.path.append(.fact(FactFeature.State()))
                    
                case .paid:
                    break
                    
                case .comingSoon:
                    break
                }
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
