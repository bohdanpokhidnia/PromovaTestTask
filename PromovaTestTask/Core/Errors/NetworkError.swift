//
//  NetworkError.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidRequestURL
    case dataLoading(error: Error)
    case decoding(error: Error)
}
