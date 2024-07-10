//
//  IfLetLandscape.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI

struct IfLetLandscape: ViewModifier {
    let width: CGFloat
    @Environment(\.deviceOrientationObserver) private var deviceOrientationObserver
    
    func body(content: Content) -> some View {
        if deviceOrientationObserver.orientation.isLandscape {
            content
                .frame(width: width)
        } else {
            content
        }
    }
}

extension View {
    func ifLetLandscape(width: CGFloat) -> some View {
        self
            .modifier(IfLetLandscape(width: width))
    }
}
