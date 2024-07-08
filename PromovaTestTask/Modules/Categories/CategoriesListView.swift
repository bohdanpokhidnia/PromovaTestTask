//
//  CategoriesListView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI

struct CategoriesListView: View {
    private var categoryTypes: [CategoryType] = [.free, .paid, .comingSoon]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(categoryTypes, id: \.self) { (categoryType) in
                        if categoryType == .comingSoon {
                            CategoryRow(categoryType: categoryType)
                        } else {
                            NavigationLink {
                                Text("Text")
                            } label: {
                                CategoryRow(categoryType: categoryType)
                            }
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
