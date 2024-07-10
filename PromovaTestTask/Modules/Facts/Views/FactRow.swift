//
//  FactRow.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct FactRow: View {
    var proxy: GeometryProxy?
    var containerWidth: CGFloat = .zero
    let content: CategoryContent
    var leadingButtonTapped: () -> Void
    var trailingButtonTapped: () -> Void
    
    private let imageHeightProportion: CGFloat = 234.0 / 700.0
    private let defaultImageWidth: CGFloat = 315.0
    private let defaultImageHeight: CGFloat = 234.0
    private let imagePadding: CGFloat = 10.0
    
    var body: some View {
        VStack(spacing: 0) {
            ImageLoading(urlString: content.image)
                .frame(width: imageWidth, height: imageHeight)
                .clipped()
                .padding([.top, .horizontal], imagePadding)
            
            Text(content.fact)
                .font(.factDescription)
                .foregroundStyle(.factText)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .padding(.top, 17)
                .padding(.horizontal, 10)
            
            Spacer()
            
            HStack(spacing: 0) {
                Button {
                    leadingButtonTapped()
                } label: {
                    Image(.factLeadingArrow)
                }
                
                Spacer()
                
                Button {
                    trailingButtonTapped()
                } label: {
                    Image(.factTrailingArrow)
                }
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 20)
        }
    }
    
    var imageWidth: CGFloat {
        let width = containerWidth - (imagePadding * 2)
        return width
    }
    
    var imageHeight: CGFloat {
        guard let proxy else {
            return defaultImageHeight
        }
        let height = imageHeightProportion * proxy.size.height
        return height
    }
}

@available(iOS 17.0, *)
#Preview("FactRow", traits: .sizeThatFitsLayout) {
    FactRow(
        content: .mock,
        leadingButtonTapped: { },
        trailingButtonTapped: { }
    )
    .frame(height: 435)
}
