//
//  PremiumView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI

struct PremiumView: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(.lock)
                .frame(width: 10, height: 12)
            
            Text("Premium")
                .font(.rowTitle)
                .foregroundStyle(.categoryPaid)
        }
    }
}

@available(iOS 17.0, *)
#Preview("PremiumView", traits: .sizeThatFitsLayout) {
    PremiumView()
}
