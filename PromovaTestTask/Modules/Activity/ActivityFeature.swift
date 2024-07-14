//
//  ActivityFeature.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 14.07.2024.
//

import ComposableArchitecture

@Reducer
struct ActivityFeature {
    @ObservableState
    struct State: Equatable {
        let sharedItem: SharedItem
    }
    
    enum Action {
        case dismiss
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .dismiss:
                return .none
            }
        }
    }
}
