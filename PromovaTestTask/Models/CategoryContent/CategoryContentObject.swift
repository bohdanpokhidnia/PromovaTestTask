//
//  CategoryContentObject.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 16.07.2024.
//

import Foundation
import RealmSwift

final class CategoryContentObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var fact: String
    @Persisted var imageData: Data
    
    func update(
        from categoryContent: CategoryContent,
        imageData: Data? = nil
    ) {
        self.fact = categoryContent.fact
        
        if let imageData {
            self.imageData = imageData
        }
    }
}
