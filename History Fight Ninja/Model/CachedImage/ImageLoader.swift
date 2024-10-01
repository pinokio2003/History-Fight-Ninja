//
//  ImageLoader.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 01.10.2024.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var imageName: String
    private var cache: NSCache<NSString, UIImage>?

    init(imageName: String, cache: NSCache<NSString, UIImage>? = nil) {
        self.imageName = imageName
        self.cache = cache
    }

    func load() {
        if let cachedImage = cache?.object(forKey: imageName as NSString) {
            self.image = cachedImage
            return
        }

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            if let image = UIImage(named: self.imageName)?.preparingThumbnail(of: CGSize(width: 100, height: 100)) {
                DispatchQueue.main.async {
                    self.cache?.setObject(image, forKey: self.imageName as NSString)
                    self.image = image
                }
            }
        }
    }

    func unload() {
        image = nil
    }
}

