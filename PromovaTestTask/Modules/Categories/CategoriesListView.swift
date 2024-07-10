//
//  CategoriesListView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct CategoriesListView: View {
    @Perception.Bindable var store: StoreOf<CategoriesList>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(store.categories) { (category) in
                            Button {
                                store.send(.categoryViewTapped(category: category))
                            } label: {
                                CategoryRow(category: category)
                            }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 15)
                    .opacity(store.isLoading ? 0 : 1)
                }
                .background(.appBackground)
                .overlay(content: {
                    if store.isLoading {
                        ProgressView()
                    }
                })
                .onAppear {
                    store.send(.onAppear)
                }
                .alert($store.scope(state: \.alert, action: \.alert))
            } destination: { (store) in
                switch store.case {
                case let .fact(factStore):
                    FactView(store: factStore)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CategoriesListView(
            store: Store(
                initialState: CategoriesList.State(
                    isLoading: false,
                    categories: [
                        .mockFree,
                        .mockPaid,
                        .mockСomingSoon,
                    ]
                )
            ) {
                CategoriesList()
            }
        )
    }
}
