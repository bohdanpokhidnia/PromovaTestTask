//
//  ActivityView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 14.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct ActivityView: UIViewControllerRepresentable {
    var store: StoreOf<ActivityFeature>

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let viewController = UIActivityViewController(
            activityItems: [
                store.sharedItem.text
            ],
            applicationActivities: nil
        )
        viewController.completionWithItemsHandler = { (activityType, isSuccess, _, _) in
            guard isSuccess else {
                return
            }
            
            store.send(.dismiss)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {
        
    }
}
