//
//  LocalStorageLive.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 16.07.2024.
//

import Foundation
import ComposableArchitecture
import RealmSwift

extension LocalStorage: DependencyKey {
    static var liveValue = LocalStorage(
        fetchCategories: { (dependencies) in
            let realm = dependencies.realm
            let results = realm.objects(CategoryObject.self)
            let categories = Array(results)
            return categories
        },
        addCategory: { (dependencies, category) in
            let realm = dependencies.realm
            
            try! realm.write {
                realm.add(category)
                print("[dev] save \(category.title)")
            }
        },
        updateCategory: { (dependencies, id, category, imageData) in
            let realm = dependencies.realm
            
            do {
                let objectId = try ObjectId(string: id)
                
                if let categoryObject = realm.object(ofType: CategoryObject.self, forPrimaryKey: objectId) {
                    try realm.write {
                        let _ = categoryObject.update(from: category, imageData: imageData)
                        print("[dev] updated \(category.title)")
                    }
                    
                    return nil
                } else {
                    return .updatedObjectIsNil
                }
            } catch {
                return .failedUpdateObject(error: error)
            }
        },
        removeCategory: { (dependencies, id) in
            
        }
    )
}

extension DependencyValues {
    var localStorage: LocalStorage {
        get { self[LocalStorage.self] }
        set { self[LocalStorage.self] = newValue }
    }
}
