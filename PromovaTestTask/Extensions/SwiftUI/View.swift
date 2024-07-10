//
//  View.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 09.07.2024.
//

import SwiftUI

extension View {
    var safeArea: UIEdgeInsets {
        guard let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
    
    func updateBackButton(resource: ImageResource) -> some View {
        let image = UIImage(resource: resource)
            .withRenderingMode(.alwaysOriginal)
        
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        return self
    }
    
    func setupNavigationBar(titleAttributes: [NSAttributedString.Key: Any]) -> some View {
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
        return self
    }
}
