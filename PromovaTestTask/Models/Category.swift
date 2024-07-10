//
//  Category.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct Category: Identifiable, Decodable {
    var id = UUID()
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: CategoryStatus
    let content: [CategoryContent]?
    
    enum CodingKeys: CodingKey {
        case title
        case description
        case image
        case order
        case status
        case content
    }
}

extension Category {
    static let mockFree = Category(
        title: "Mock title",
        description: "Mock description",
        image: "https://picsum.photos/300/200",
        order: 0,
        status: .free,
        content: nil
    )
    
    static let mockPaid = Category(
        title: "Mock title",
        description: "Mock description",
        image: "https://picsum.photos/300/200",
        order: 0,
        status: .paid,
        content: nil
    )
    
    static let mockСomingSoon = Category(
        title: "Mock title",
        description: "Mock description",
        image: "https://picsum.photos/300/200",
        order: 0,
        status: .comingSoon,
        content: nil
    )
}
