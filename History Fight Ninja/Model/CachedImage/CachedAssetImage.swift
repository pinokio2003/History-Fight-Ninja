//
//  CachedAssetImage.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 01.10.2024.
//

import SwiftUI

struct CachedImage: View {
    let imageName: String
    @ObservedObject var preloader: ImagePreloader

    var body: some View {
        Group {
            if let image = preloader.getImage(imageName) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray
            }
        }
//        .frame(width: 100, height: 100)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
