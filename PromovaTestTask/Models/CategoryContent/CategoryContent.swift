//
//  CategoryContent.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation

struct CategoryContent: Identifiable, Decodable {
    var id = UUID()
    let fact: String
    var image: String?
    var imageData: Data?
    
    enum CodingKeys: CodingKey {
        case fact
        case image
    }
    
    // MARK: - Initializers
    
    init(
        fact: String,
        image: String? = nil,
        imageData: Data? = nil
    ) {
        self.fact = fact
        self.image = image
        self.imageData = imageData
    }
    
    init(categoryContentObject: CategoryContentObject) {
        self.fact = categoryContentObject.fact
        self.imageData = categoryContentObject.imageData
    }
}

extension CategoryContent {
    static let mock = CategoryContent(
        fact: "Scholars have argued over the metaphysical interpretation of Dorothy’s pooch, Toto, in the Wizard of Oz. One theory postulates that Toto represents Anubis, the dog-headed Egyptian god of death, because Toto consistently keeps Dorothy from safely returning home.",
        image: "https://picsum.photos/300/200"
    )
    
    static let mock1 = CategoryContent(
        fact: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus enim.",
        image: "https://picsum.photos/300/200"
    )
}
