//
//  Font.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import SwiftUI

extension Font {
    static let appNavigationTitle = Font.ptSansRegular(size: 17)
    
    static let rowTitle = Font.ptSansRegular(size: 16)
    
    static let rowSubtitle = Font.ptSansRegular(size: 12)
    
    static let factDescription = Font.ptSansRegular(size: 18)
    
    static func ptSansRegular(size: CGFloat) -> Font {
        .custom("PTSans-Regular", size: size)
    }
}
