//
//  EmptyFactView.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI

struct EmptyFactView: View {
    let factCategoryTitle: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Sorry, we do not have any fact about the \(factCategoryTitle)")
            
            Text("We are working ⚙️")
        }
        .font(.rowTitle)
    }
}

#Preview {
    EmptyFactView(factCategoryTitle: "Panda 🐼")
}
