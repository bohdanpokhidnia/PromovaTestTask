//
//  FactView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 09.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct FactView: View {
    @Perception.Bindable var store: StoreOf<FactFeature>
    private let imageHeightProportion: CGFloat = 234.0 / 700.0
    private let containerHeightProportion: CGFloat = 435.0 / 700.0
    
    @Dependency(\.deviceOrientationObserver) private var deviceOrientationObserver
    
    var body: some View {
        GeometryReader { (proxy) in
            let factImageHeight = imageHeightProportion * proxy.size.height
            let factViewHeight = max(0, calculationFactViewHeight(
                proxy: proxy,
                orientation: deviceOrientationObserver.orientation
            ))
            
            Rectangle()
                .fill(.appBackground)
                .overlay(alignment: .top) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundStyle(.factText)
                            .frame(height: factImageHeight)
                            .padding([.top, .horizontal], 10)
                        
                        Text(deviceOrientationObserver.orientation.isLandscape ? "Landscape mode" : "Fact text")
                            .font(.factDescription)
                            .foregroundStyle(.factText)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.8)
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
                    .ifLetLandscape(width: proxy.size.width / 2.5)
                    .background(.factBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(color: .factShadow, radius: 60, y: 20)
                    .padding(.top, factViewTopPadding)
                    .padding(.horizontal, 20)
                }
                .navigationTitle("Category Title")
                .background(.appBackground)
        }
    }
    
    private var factViewTopPadding: CGFloat {
        deviceOrientationObserver.orientation.isLandscape ? 20.0 : 50.0
    }
    
    private func calculationFactViewHeight(
        proxy: GeometryProxy,
        orientation: UIDeviceOrientation
    ) -> CGFloat {
        orientation.isLandscape
        ? proxy.size.height - factViewTopPadding - CGFloat((safeArea.bottom == .zero) ? factViewTopPadding : safeArea.bottom)
        : containerHeightProportion * proxy.size.height
    }
}

#Preview {
    NavigationStack {
        FactView(store: Store(initialState: FactFeature.State(category: .mockFree)) {
            FactFeature()
        })
    }
}
