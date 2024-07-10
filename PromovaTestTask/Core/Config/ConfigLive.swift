//
//  ConfigLive.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import ComposableArchitecture

extension Config: DependencyKey {
    static var liveValue = Config(apiURL: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json")
}

extension DependencyValues {
    var config: Config {
        get { self[Config.self] }
        set { self[Config.self] = newValue }
    }
}
