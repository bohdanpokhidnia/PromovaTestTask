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
    struct State: Equatable {
        var factFeature = FactFeature.State()
    }
    
    enum Action {
        case factFeature(FactFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .factFeature:
                return .none
            }
        }
    }
}
