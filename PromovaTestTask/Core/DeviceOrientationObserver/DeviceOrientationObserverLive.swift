//
//  DeviceOrientationObserverLive.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import ComposableArchitecture

extension DeviceOrientationObserver: DependencyKey {
    static var liveValue: DeviceOrientationObserver = DeviceOrientationObserver()
}

extension DependencyValues {
    var deviceOrientationObserver: DeviceOrientationObserver {
        get { self[DeviceOrientationObserver.self] }
        set { self[DeviceOrientationObserver.self] = newValue }
    }
}
