//
//  CategoriesListView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI

struct CategoriesListView: View {
    private var categoriesStatus: [CategoryStatus] = [.free, .paid, .comingSoon]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(categoriesStatus, id: \.self) { (categoryStatus) in
                        if categoryStatus == .free {
                            NavigationLink {
                                FactView()
                            } label: {
                                CategoryRow(categoryType: categoryStatus)
                            }
                        } else {
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
    CategoriesListView()
}
