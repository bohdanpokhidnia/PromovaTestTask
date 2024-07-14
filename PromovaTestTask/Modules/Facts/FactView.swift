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
    private let factRowHorizontalPadding: CGFloat = 20.0
    private let containerHeightProportion: CGFloat = 435.0 / 700.0
    
    @Dependency(\.deviceOrientationObserver) private var deviceOrientationObserver
    
    var body: some View {
        GeometryReader { (proxy) in
            let factRowWidth = max(
                0,
                calculationFactViewWidth(
                    proxy: proxy,
                    orientation: deviceOrientationObserver.orientation
                )
            )
            let factRowHeight = max(
                0,
                calculationFactViewHeight(
                    proxy: proxy,
                    orientation: deviceOrientationObserver.orientation
                )
            )
            
            WithPerceptionTracking {
                TabView(selection: $store.currentTabIndex.sending(\.selectTabIndex)) {
                    ForEach(store.category.content) { (content) in
                        Color.clear
                            .overlay(alignment: .top) {
                                FactRow(
                                    proxy: proxy,
                                    containerWidth: factRowWidth,
                                    content: content,
                                    leadingButtonTapped: {
                                        store.send(.leadingButtonTapped)
                                    },
                                    trailingButtonTapped: {
                                        store.send(.trailingButtonTapped)
                                    },
                                    shareButtonTapped: {
                                        store.send(.shareButtonTapped)
                                    }
                                )
                                .frame(width: factRowWidth, height: factRowHeight)
                                .background(.factBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .shadow(color: .factShadow, radius: 60, y: 20)
                                .padding(.top, factRowTopPadding)
                            }
                            .tag(store.category.content.index(id: content.id) ?? 0)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .navigationTitle(store.category.title)
                .background(.appBackground)
                .ignoresSafeArea(edges: [.horizontal, .bottom])
                .overlay(content: {
                    if store.category.content.isEmpty {
                        EmptyFactView(factCategoryTitle: store.category.title)
                    }
                })
            }
            .sheet(item: $store.scope(state: \.activity, action: \.activity)) { (store) in
                ActivityView(store: store)
            }
        }
    }
    
    private var factRowTopPadding: CGFloat {
        deviceOrientationObserver.orientation.isLandscape ? 20.0 : 50.0
    }
    
    private var safeAreaBottomPadding: CGFloat {
        CGFloat((safeArea.bottom == .zero) ? factRowTopPadding : safeArea.bottom)
    }
    
    private func calculationFactViewWidth(
        proxy: GeometryProxy,
        orientation: UIDeviceOrientation
    ) -> CGFloat {
        orientation.isLandscape
        ? proxy.size.width / 3.5
        : proxy.size.width - (factRowHorizontalPadding * 2)
    }
    
    private func calculationFactViewHeight(
        proxy: GeometryProxy,
        orientation: UIDeviceOrientation
    ) -> CGFloat {
        orientation.isLandscape
        ? proxy.size.height - factRowTopPadding - safeAreaBottomPadding
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
