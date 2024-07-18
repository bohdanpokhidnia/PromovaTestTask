//
//  DeviceOrientationObserverEnvironmentKey.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 18.07.2024.
//

import SwiftUI

struct DeviceOrientationObserverEnvironmentKey: EnvironmentKey {
    static var defaultValue = DeviceOrientationObserver()
}

extension EnvironmentValues {
    var deviceOrientationObserver: DeviceOrientationObserver {
        get { self[DeviceOrientationObserverEnvironmentKey.self] }
        set { self[DeviceOrientationObserverEnvironmentKey.self] = newValue }
    }
}
