//
//  CategoryType.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import Foundation

enum CategoryType: String, FallbackCase {
    static var fallbackCase: CategoryType { .comingSoon }
    
    case paid
    case free
    case comingSoon = "coming_soon"
}
