//
//  TestView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 27.09.2024.
//

import SwiftUI

struct CountryPickerViewChild: View {
    let id: Int
    let imageName: String
    @ObservedObject var preloader: ImagePreloader

    var body: some View {
        CachedImage(imageName: imageName, preloader: preloader)
    }
}
