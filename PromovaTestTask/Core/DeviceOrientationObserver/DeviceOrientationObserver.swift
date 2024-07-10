//
//  DeviceOrientationObserver.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI
import Combine

final class DeviceOrientationObserver: ObservableObject {
    @Published var orientation: UIDeviceOrientation
    
    // MARK: - Initializers
    
    init(orientation: UIDeviceOrientation = UIDevice.current.orientation) {
        self.orientation = orientation
        
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .sink { [weak self] _ in
                self?.orientation = UIDevice.current.orientation
            }
            .store(in: &bag)
    }
    
    // MARK: - Private
    
    private var bag = Set<AnyCancellable>()
}
