//
//  FactFeature.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct FactFeature {
    @ObservableState
    struct State: Equatable {
        var currentTabIndex: Int = 0
        let category: Category
    }
    
    enum Action {
        case leadingButtonTapped
        case trailingButtonTapped
        case decreaseCurrentTabIndex
        case increaseCurrentTabIndex
        case selectTabIndex(Int)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .leadingButtonTapped:
                guard state.currentTabIndex >= 0 else {
                    return .none
                }
                return .send(.decreaseCurrentTabIndex)
                
            case .trailingButtonTapped:
                guard state.currentTabIndex < state.category.content.count - 1 else {
                    return .none
                }
                return .send(.increaseCurrentTabIndex)
                
            case .decreaseCurrentTabIndex:
                state.currentTabIndex -= 1
                return .none
                
            case .increaseCurrentTabIndex:
                state.currentTabIndex += 1
                return .none
                
            case let .selectTabIndex(index):
                state.currentTabIndex = index
                return .none
            }
        }
    }
}
