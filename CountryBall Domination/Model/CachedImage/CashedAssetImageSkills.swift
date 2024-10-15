//
//  CashedAssetImageSkills.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 02.10.2024.
//

import SwiftUI

struct CashedAssetImageSkills: View {
    @StateObject private var loader: ImageLoader
    private let cache: NSCache<NSString, UIImage>
    
    init(imageName: String, cache: NSCache<NSString, UIImage>) {
        self.cache = cache
        _loader = StateObject(wrappedValue: ImageLoader(imageName: imageName, cache: cache))
    }
    
    var body: some View {
        ZStack {
            if let image = loader.image {
                // Показываем изображение, если оно загружено
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
            } else {
                // Прелоадер во время загрузки
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: 40, height: 40)
                
            }
        }
        .onAppear(perform: loader.load)
        .onDisappear(perform: loader.unload)
    }
}


