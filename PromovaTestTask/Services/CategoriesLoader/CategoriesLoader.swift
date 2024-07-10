//
//  CategoriesLoader.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation
import ComposableArchitecture

struct CategoriesLoader {
    var fetchCategories: () async -> Result<[Category], Error>
}
