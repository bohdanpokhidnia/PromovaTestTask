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
    private let categoriesStatus: [CategoryStatus] = [.free, .paid, .comingSoon]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(categoriesStatus, id: \.self) { (categoryStatus) in
                        NavigationLink {
                            FactView(store: store.scope(state: \.factFeature, action: \.factFeature))
                        } label: {
                            CategoryRow(categoryType: categoryStatus)
                        }
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 15)
            }
            .background(.appBackground)
        }
    }
}

#Preview {
    CategoriesListView(
        store: Store(
            initialState: CategoriesList.State()
            ,reducer: {
                CategoriesList()
            })
    )
}
