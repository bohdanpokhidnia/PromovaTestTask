//
//  CategoryType.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import Foundation

enum CategoryStatus: String, FallbackCase {
    static var fallbackCase: CategoryStatus { .comingSoon }
    
    case paid
    case free
    case comingSoon = "coming_soon"
}
