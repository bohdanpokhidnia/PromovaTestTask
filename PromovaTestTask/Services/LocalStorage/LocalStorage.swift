//
//  LocalStorage.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 16.07.2024.
//

import SwiftUI
import RealmSwift

@MainActor
struct LocalStorage {
    var fetchCategories: (LocalStorageDependencies) async -> [CategoryObject]
    var addCategory: (LocalStorageDependencies, CategoryObject) async -> Void
    var updateCategory: (
        LocalStorageDependencies,
        String,
        Category,
        Data?
    ) async -> LocalStorageError?
    var removeCategory: (LocalStorageDependencies, String) async -> Void
}

struct LocalStorageDependencies {
    let realm: Realm
    
    // MARK: - Initializers
    
    init() throws {
        do {
            self.realm = try Realm()
        } catch {
            print("[dev] Realm don't init")
            throw error
        }
    }
}
