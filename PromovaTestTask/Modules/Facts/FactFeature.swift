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
        let category: Category
        var currentTabIndex: Int = 0
        @Presents var activity: ActivityFeature.State?
    }
    
    enum Action {
        case activity(PresentationAction<ActivityFeature.Action>)
        case decreaseCurrentTabIndex
        case increaseCurrentTabIndex
        case leadingButtonTapped
        case selectTabIndex(Int)
        case shareButtonTapped
        case trailingButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .activity(.presented(.dismiss)):
                state.activity = nil
                return .none
                
            case .activity:
                return .none
                
            case .decreaseCurrentTabIndex:
                state.currentTabIndex -= 1
                return .none
                
            case .increaseCurrentTabIndex:
                state.currentTabIndex += 1
                return .none
                
            case .leadingButtonTapped:
                guard state.currentTabIndex >= 0 else {
                    return .none
                }
                return .send(.decreaseCurrentTabIndex)
                
            case let .selectTabIndex(index):
                state.currentTabIndex = index
                return .none
                
            case .shareButtonTapped:
                let content = state.category.content[state.currentTabIndex]
                let sharedItem = SharedItem(text: content.fact)
                state.activity = ActivityFeature.State(sharedItem: sharedItem)
                return .none
                
            case .trailingButtonTapped:
                guard state.currentTabIndex < state.category.content.count - 1 else {
                    return .none
                }
                return .send(.increaseCurrentTabIndex)
            }
        }
        .ifLet(\.$activity, action: \.activity) {
            ActivityFeature()
        }
    }
}
