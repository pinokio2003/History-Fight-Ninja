//
//  CachedAssetImage.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 01.10.2024.
//

import SwiftUI

struct CachedAssetImage: View {
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
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray
            }
        }
        .frame(width: 150, height: 150)
        .shadow(color: .blue, radius: 20, x: 2, y: 2)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear(perform: loader.load)
        .onDisappear(perform: loader.unload)
    }
}
