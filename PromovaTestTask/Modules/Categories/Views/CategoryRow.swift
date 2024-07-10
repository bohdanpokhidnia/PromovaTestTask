//
//  CategoryRow.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI

struct CategoryRow: View {
    let category: Category
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Rectangle()
                .fill(.red)
                .frame(width: 121, height: 90)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(category.title)
                    .font(.rowTitle)
                    .foregroundStyle(.categoryTitle)
                
                Text(category.description)
                    .font(.rowSubtitle)
                    .foregroundStyle(.categorySubtitle)
                
                Spacer()
                
                if category.status == .paid {
                    HStack(spacing: 4) {
                        Image(.lock)
                            .frame(width: 10, height: 12)
                        
                        Text("Premium")
                            .font(.rowTitle)
                            .foregroundStyle(.categoryPaid)
                    }
                    .padding(.bottom, 2)
                }
            }
            .padding(.top, 5)
            .padding(.leading, 17)
            
            Spacer()
        }
        .padding(5)
        .background(.categoryBackground)
        .overlay(alignment: .trailing) {
            if category.status == .comingSoon {
                Image(.comingSoon)
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 3.46)
            }
        }
        .overlay(content: {
            if category.status == .comingSoon {
                Rectangle()
                    .fill(.categoryComingSoon)
            }
        })
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .ifLetShadow(
            isDisplayShadow: category.status != .comingSoon,
            color: .categoryShadow,
            radius: 2,
            y: 2
        )
    }
}

@available(iOS 17.0, *)
#Preview("CategoryRow", traits: .sizeThatFitsLayout) {
    CategoryRow(category: .mock)
        .frame(height: 100)
        .padding(.horizontal, 15)
}
