//
//  Test.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 02.10.2024.
//

import SwiftUI
import Combine

class ImagePreloader: ObservableObject {
    @Published var isLoading = true
    private var cache = NSCache<NSString, UIImage>()
    private var loadingTasks: [AnyCancellable] = []

    func preloadImages(_ imageNames: [String]) {
        let group = DispatchGroup()

        for imageName in imageNames {
            group.enter()
            loadImage(imageName) {
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.isLoading = false
        }
    }

    private func loadImage(_ imageName: String, completion: @escaping () -> Void) {
        if let _ = cache.object(forKey: imageName as NSString) {
            completion()
            return
        }

        let task = Future<UIImage?, Never> { promise in
            DispatchQueue.global(qos: .userInitiated).async {
                if let image = UIImage(named: imageName)?.preparingThumbnail(of: CGSize(width: 100, height: 100)) {
                    self.cache.setObject(image, forKey: imageName as NSString)
                    promise(.success(image))
                } else {
                    promise(.success(nil))
                }
            }
        }
        .sink { _ in
            completion()
        }

        loadingTasks.append(task)
    }

    func getImage(_ imageName: String) -> UIImage? {
        cache.object(forKey: imageName as NSString)
    }
}
