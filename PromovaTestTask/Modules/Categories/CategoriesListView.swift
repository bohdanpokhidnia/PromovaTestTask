//
//  CategoriesListView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct CategoriesListView: View {
    var store: StoreOf<CategoriesList>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(store.categories) { (category) in
                        if category.status == .free {
                            NavigationLink {
                                FactView(store: store.scope(state: \.factFeature, action: \.factFeature))
                            } label: {
                                CategoryRow(category: category)
                            }
                        } else {
                            Button {
                                
                            } label: {
                                CategoryRow(category: category)
                            }
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
        }
    }
}

#Preview {
    NavigationStack {
        CategoriesListView(
            store: Store(
                initialState: CategoriesList.State(
                    isLoading: false,
                    categories: [.mockFree, .mockPaid, .mockСomingSoon]
                )
            ) {
                CategoriesList()
            }
        )
    }
}
