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
    let content: IdentifiedArrayOf<CategoryContent>
    
    enum CodingKeys: CodingKey {
        case title
        case description
        case image
        case order
        case status
        case content
    }
    
    // MARK: - Initializers
    
    init(
        title: String,
        description: String,
        image: String,
        order: Int,
        status: CategoryStatus,
        content: IdentifiedArrayOf<CategoryContent>
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.order = order
        self.status = status
        self.content = content
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
        self.order = try container.decode(Int.self, forKey: .order)
        self.status = try container.decode(CategoryStatus.self, forKey: .status)
        self.content = IdentifiedArray(uniqueElements: try container.decodeIfPresent([CategoryContent].self, forKey: .content) ?? [])
    }
}

// MARK: - Equatable

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}

extension Category {
    static let mockFree = Category(
        title: "Mock title",
        description: "Mock description",
        image: "https://picsum.photos/300/200",
        order: 0,
        status: .free,
        content: [
            .mock,
            .mock1,
        ]
    )
    
    static let mockPaid = Category(
        title: "Mock title",
        description: "Mock description",
        image: "https://picsum.photos/300/200",
        order: 0,
        status: .paid,
        content: []
    )
    
    static let mockСomingSoon = Category(
        title: "Coming Soon title",
        description: "Mock description",
        image: "https://picsum.photos/300/200",
        order: 0,
        status: .comingSoon,
        content: []
    )
}
