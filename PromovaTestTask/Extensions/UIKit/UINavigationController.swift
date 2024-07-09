//
//  UINavigationController.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 09.07.2024.
//

import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationBar.backItem?.backButtonTitle = ""
        
        setupShadow(
            isTranslucent: true,
            navigationBarBackgroundColor: .appBackground,
            shadowColor: .black,
            shadowOpacity: 0.25,
            shadowOffset: CGSize(width: 0, height: 6),
            shadowRadius: 3.0
        )
    }
}

// MARK: - Private Methods

private extension UINavigationController {
    func setupShadow(
        isTranslucent: Bool,
        navigationBarBackgroundColor: UIColor,
        shadowColor: UIColor,
        shadowOpacity: Float,
        shadowOffset: CGSize,
        shadowRadius: CGFloat
    ) {
        navigationBar.isTranslucent = isTranslucent
        navigationBar.backgroundColor = navigationBarBackgroundColor
        navigationBar.layer.shadowColor = shadowColor.cgColor
        navigationBar.layer.shadowOpacity = shadowOpacity
        navigationBar.layer.shadowOffset = shadowOffset
        navigationBar.layer.shadowRadius = shadowRadius
    }
}
