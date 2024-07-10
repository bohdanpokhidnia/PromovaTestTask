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
    let image: String
    
    enum CodingKeys: CodingKey {
        case fact
        case image
    }
}

extension CategoryContent {
    static let mock = CategoryContent(
        fact: "Scholars have argued over the metaphysical interpretation of Dorothy’s pooch, Toto, in the Wizard of Oz. One theory postulates that Toto represents Anubis, the dog-headed Egyptian god of death, because Toto consistently keeps Dorothy from safely returning home.",
        image: "https://picsum.photos/300/200"
    )
}
