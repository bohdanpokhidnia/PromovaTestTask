//
//  SharedItem.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 14.07.2024.
//

import Foundation

struct SharedItem: Identifiable, Equatable {
    var id = UUID()
    let text: String
}
