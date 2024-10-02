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
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
                
            } else {
                Color.gray
            }
        }
        .onAppear(perform: loader.load)
        .onDisappear(perform: loader.unload)
    }
}

