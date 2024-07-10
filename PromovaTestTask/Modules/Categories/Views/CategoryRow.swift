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
            ImageLoading(
                urlString: category.image
            )
            .frame(width: 121, height: 90)
            .clipped()
            
            VStack(alignment: .leading, spacing: 0) {
                Text(category.title)
                    .font(.rowTitle)
                    .foregroundStyle(.categoryTitle)
                
                Text(category.description)
                    .font(.rowSubtitle)
                    .foregroundStyle(.categorySubtitle)
                
                Spacer()
                
                if category.status == .paid {
                    PremiumView()
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
#Preview("СomingSoon", traits: .sizeThatFitsLayout) {
    VStack {
        CategoryRow(category: .mockFree)
            .frame(height: 100)
            .padding(.horizontal, 15)
        
        CategoryRow(category: .mockPaid)
            .frame(height: 100)
            .padding(.horizontal, 15)
        
        CategoryRow(category: .mockСomingSoon)
            .frame(height: 100)
            .padding(.horizontal, 15)
    }
}
