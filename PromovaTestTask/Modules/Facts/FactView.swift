//
//  FactView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 09.07.2024.
//

import SwiftUI

struct FactView: View {
    private let imageHeightProportion: CGFloat = 234 / 700
    private let viewHeightProportion: CGFloat = 435 / 700
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        GeometryReader { (proxy) in
            let factImageHeight = imageHeightProportion * proxy.size.height
            let factViewHeight = viewHeightProportion * proxy.size.height
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundStyle(.factText)
                        .frame(height: factImageHeight)
                        .padding([.top, .horizontal], 10)
                    
                    Text(horizontalSizeClass == .compact && verticalSizeClass == .regular ? "Fact text" : "Landscape mode")
                        .font(.factDescription)
                        .foregroundStyle(.factText)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .padding(.top, 17)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Button {
                            
                        } label: {
                            Image(.factLeadingArrow)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(.factTrailingArrow)
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 20)
                }
                .frame(height: factViewHeight)
                .background(.factBackground)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(color: .factShadow, radius: 60, y: 20)
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.horizontal, 20)
            .background(.appBackground)
            .navigationTitle("Category Title")
        }
    }
}

#Preview {
    NavigationStack {
        FactView()
    }
}
