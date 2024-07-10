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
        var selectedTabIndex: Int = 0
        let category: Category
    }
    
    enum Action {
        case selectTabIndex(Int)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case let .selectTabIndex(index):
                state.selectedTabIndex = index
                return .none
            }
        }
    }
}
