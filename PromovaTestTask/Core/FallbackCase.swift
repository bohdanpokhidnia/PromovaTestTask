//
//  FallbackCase.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 08.07.2024.
//

import Foundation

protocol FallbackCase: RawRepresentable, Codable {
    static var fallbackCase: Self { get }
}

extension FallbackCase where RawValue: Codable {
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(RawValue.self)
        
        self = Self(rawValue: value) ?? Self.fallbackCase
    }
}
