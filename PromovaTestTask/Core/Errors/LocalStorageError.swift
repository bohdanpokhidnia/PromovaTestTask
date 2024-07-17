//
//  LocalStorageError.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 16.07.2024.
//

import Foundation

enum LocalStorageError: Error {
    case failedRead(error: Error)
    case failedAddObject(error: Error)
    case failedUpdateObject(error: Error)
    case updatedObjectIsNil
    case failedRemoveObject(error: Error)
    case removedObjectIsNil
}
