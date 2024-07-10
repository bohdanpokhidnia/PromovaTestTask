//
//  ImageLoading.swift
//  PromovaTestTask
//
//  Created by Bohdan Pokhidnia on 10.07.2024.
//

import SwiftUI

struct ImageLoading: View {
    var uiImage: UIImage?
    var urlString: String?
    var contentMode: ContentMode = .fill
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: contentMode)
            
        } else if let urlString {
            AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                case .empty:
                    placeholder
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                    
                case .failure:
                    placeholder
                    
                @unknown default:
                    placeholder
                }
            }
        } else {
            Rectangle()
                .fill(.gray)
        }
    }
    
    private var placeholder: some View {
        ZStack {
            Rectangle()
                .fill(.gray.opacity(0.4))
            
            ProgressView()
        }
    }
}

#Preview {
    ImageLoading(urlString: Category.mockFree.image)
        .frame(width: 300, height: 200)
}
