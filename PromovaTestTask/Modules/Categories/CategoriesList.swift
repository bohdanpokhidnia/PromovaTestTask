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
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        case alert(PresentationAction<Alert>)
        case categoriesResponse(categories: [Category])
        case categoryViewTapped(category: Category)
        case network(error: NetworkError)
        case onAppear
        case order(categories: [Category])
        case path(StackActionOf<Path>)
        case timerFire(category: Category)
        
        enum Alert {
            case showAd(id: UUID)
        }
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case fact(FactFeature)
    }
    
    enum CancelID {
        case timer
    }
    
    @Dependency(\.categoriesLoader) private var categoriesLoader
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case let .alert(.presented(.showAd(id))):
                guard let category = state.categories[id: id] else {
                    return .none
                }
                state.isLoading = true
                
                return .run { (send) in
                    for await _ in clock.timer(interval: .seconds(2)) {
                        await send(.timerFire(category: category))
                    }
                }
                .cancellable(id: CancelID.timer)
                
            case .alert:
                return .none
                
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
                        await send(.order(categories: categories))
                        
                    case let .failure(error):
                        await send(.network(error: error))
                    }
                }
                
            case let .categoriesResponse(categories):
                state.isLoading = false
                state.categories = IdentifiedArray(uniqueElements: categories)
                return .none
                
            case let .categoryViewTapped(category):
                switch category.status {
                case .free:
                    state.path.append(.fact(FactFeature.State(category: category)))
                    
                case .paid:
                    state.alert = .showAd(id: category.id)
                    
                case .comingSoon:
                    state.alert = .comingSoon(title: category.title)
                }
                return .none
                
            case let .network(error):
                state.isLoading = false
                print("[dev] \(error)")
                return .none
                
            case let .order(categories):
                let orderedCategories = categories.sorted(by: { $0.order < $1.order })
                return .send(.categoriesResponse(categories: orderedCategories))
                
            case .path:
                return .none
                
            case let .timerFire(category):
                state.isLoading = false
                state.path.append(.fact(FactFeature.State(category: category)))
                return .cancel(id: CancelID.timer)
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .forEach(\.path, action: \.path)
    }
}
