//
//  CategoryLoaderDependencies.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation

struct CategoryLoaderDependencies<T: Decodable> {
    var loadData: (URL) async -> Result<Data, NetworkError> = { (url) in
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return .success(data)
        } catch {
            return .failure(.dataLoading(error: error))
        }
    }
    
    var decode: (Data, JSONDecoder) -> Result<T, NetworkError> = { (data, decoder) in
        do {
            let item = try decoder.decode(T.self, from: data)
            return .success(item)
        } catch {
            return .failure(.decoding(error: error))
        }
    }
}
