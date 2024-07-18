//
//  CategoriesListAlertStates.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import Foundation
import ComposableArchitecture

extension AlertState where Action == CategoriesList.Action.Alert {
    static func showAd(id: String) -> Self {
        Self {
            TextState("Watch Ad to continue")
        } actions: {
            ButtonState(action: .showAd(id: id)) {
                TextState("Show Ad")
            }
            
            ButtonState() {
                TextState("Cancel")
            }
        }
    }
    
    static func comingSoon(title: String) -> Self {
        Self {
            TextState(title)
        } actions: {
            ButtonState() {
                TextState("Ok")
            }
        }
    }
}
