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
        var localStorageDependencies = try! LocalStorageDependencies()
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
        case localStorage(error: LocalStorageError)
        case equal(localCategories: [CategoryObject], networkCategories: [Category])
        case save(categories: [Category])
        
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
    @Dependency(\.localStorage) var localStorage
    
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
                
                return .run { [localStorageDependencies = state.localStorageDependencies] (send) in
                    let categoryObjects = await localStorage.fetchCategories(localStorageDependencies)
                    let result = await categoriesLoader.fetchCategories(CategoryLoaderDependencies())
                    switch result {
                    case let .success(networkCategories):
                        if categoryObjects.isEmpty {
                            await send(.save(categories: networkCategories))
                            await send(.order(categories: networkCategories))
                        } else {
                            await send(.equal(localCategories: categoryObjects, networkCategories: networkCategories))
                        }
                        
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
                
            case let .localStorage(error):
                state.isLoading = false
                print("[dev] \(error)")
                return .none
                
            case let .equal(localCategories, networkCategories):
//                return .send(.order(categories: networkCategories))
                
                return .run { [localStorageDependencies = state.localStorageDependencies] (send) in
                    for localCategory in localCategories {
                        let category = Category(categoryObject: localCategory)
                        
                        if let networkCategory = networkCategories.first(where: { $0.status == category.status }) {
                            print("[dev] \(networkCategory.title)")
                            if let error = await localStorage.updateCategory(
                                localStorageDependencies,
                                localCategory.id.stringValue,
                                networkCategory,
                                nil
                            ) {
                                await send(.localStorage(error: error))
                            }
                        }
                    }
                    
                    await send(.order(categories: networkCategories))
                }
                
            case let .save(networkCategories):
                let localCategories = networkCategories.map {
                    CategoryObject()
                        .update(from: $0)
                }
                
                return .run { [localStorageDependencies = state.localStorageDependencies] (send) in
                    for localCategory in localCategories {
                        await localStorage.addCategory(localStorageDependencies, localCategory)
                    }
                }
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .forEach(\.path, action: \.path)
    }
}
