//
//  CategoryObject.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 16.07.2024.
//

import Foundation
import RealmSwift

final class CategoryObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var categoryDescription: String
    @Persisted var imageData: Data
    @Persisted var order: Int
    @Persisted var statusValue: String
    @Persisted var content: List<CategoryContentObject>
    
    func update(
        from category: Category,
        imageData: Data? = nil
    ) -> Self {
        self.title = category.title
        self.categoryDescription = category.description
        self.order = category.order
        self.statusValue = category.status.rawValue
        
        if let imageData {
            self.imageData = imageData
        }
        
        for (categoryObject, categoryContent) in zip(self.content, category.content) {
            categoryObject.update(from: categoryContent)
        }
        return self
    }
}
