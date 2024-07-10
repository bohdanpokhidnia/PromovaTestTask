//
//  RequestBuilder.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation

struct RequestBuilder {
    // MARK: - Initializers

    init(path: String?, jsonEncoder: JSONEncoder = JSONEncoder()) {
        var components = URLComponents()
        
        if let path {
            components.path = path
        }
        
        self.buildRequestHandler = { _ in }
        self.urlComponents = components
        self.jsonEncoder = jsonEncoder
    }
    
    // MARK: - Public Methods
    
    func buildRequest(baseURL: URL) -> URLRequest? {
        guard let finalURL = urlComponents.url(relativeTo: baseURL) else {
            return nil
        }
        var urlRequest = URLRequest(url: finalURL)
        buildRequestHandler(&urlRequest)
        return urlRequest
    }
    
    // MARK: - Modifiers

    func addQueryItems(_ queryItems: [URLQueryItem]) -> RequestBuilder {
        return modifyURLComponents { urlComponents in
            var items = urlComponents.queryItems ?? []
            items.append(contentsOf: queryItems)
            urlComponents.queryItems = items
        }
    }
    
    func addQueryItems(_ queryItems: [(name: String, value: String)]) -> RequestBuilder {
        return self.addQueryItems(queryItems.map { .init(name: $0.name, value: $0.value) })
    }
    
    func addQueryItem(name: String, value: String) -> RequestBuilder {
        return addQueryItems([(name: name, value: value)])
    }
    
    func setHTTPMethod(_ method: HTTPRequestMethod) -> RequestBuilder {
        return modifyURLRequest { $0.httpMethod = method.rawValue }
    }
    
    func addHTTPHeader(name: String, value: String) -> RequestBuilder {
        return modifyURLRequest { $0.addValue(value, forHTTPHeaderField: name) }
    }
    
    func setHTTPBody(_ body: Data) -> RequestBuilder {
        return modifyURLRequest { $0.httpBody = body }
    }
    
    func setHTTPJSONBody<Content: Encodable>(_ body: Content, encoder: JSONEncoder? = nil) throws -> RequestBuilder {
        let bodyData = try (encoder ?? jsonEncoder).encode(body)
        return setHTTPBody(bodyData)
    }
    
    // MARK: - Private Properties
    
    private var buildRequestHandler: (inout URLRequest) -> Void
    private let jsonEncoder: JSONEncoder
    private var urlComponents: URLComponents
}

// MARK: - Private Methods

private extension RequestBuilder {
    func modifyURLComponents(_ modify: @escaping (inout URLComponents) -> Void) -> RequestBuilder {
        var copy = self
        modify(&copy.urlComponents)
        return copy
    }
    
    func modifyURLRequest(_ modify: @escaping (inout URLRequest) -> Void) -> RequestBuilder {
        var copy = self
        let existingHandler = buildRequestHandler
        
        copy.buildRequestHandler = { request in
            existingHandler(&request)
            modify(&request)
        }
        
        return copy
    }
}
