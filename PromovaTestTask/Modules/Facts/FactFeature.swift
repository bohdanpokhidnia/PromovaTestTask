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
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
                
            }
        }
    }
}
