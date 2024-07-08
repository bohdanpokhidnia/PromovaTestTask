//
//  IfLetShadow.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI

struct IfLetShadow: ViewModifier {
    let isDisplayShadow: Bool
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    func body(content: Content) -> some View {
        if isDisplayShadow {
            content
                .shadow(color: color, radius: radius, x: x, y: y)
        } else {
            content
        }
    }
}

extension View {
    func ifLetShadow(
        isDisplayShadow: Bool,
        color: Color,
        radius: CGFloat,
        x: CGFloat = .zero,
        y: CGFloat = .zero
    ) -> some View {
        self
            .modifier(
                IfLetShadow(
                    isDisplayShadow: isDisplayShadow,
                    color: color,
                    radius: radius,
                    x: x,
                    y: y
                )
            )
    }
}
