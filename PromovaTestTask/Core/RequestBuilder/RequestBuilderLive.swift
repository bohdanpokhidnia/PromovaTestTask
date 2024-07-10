//
//  RequestBuilderLive.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import ComposableArchitecture

extension RequestBuilder: DependencyKey {
    static var liveValue = RequestBuilder(path: nil)
}

extension DependencyValues {
    var requestBuilder: RequestBuilder {
        get { self[RequestBuilder.self] }
        set { self[RequestBuilder.self] = newValue }
    }
}
