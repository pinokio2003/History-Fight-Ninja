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
    let cache: NSCache<NSString, UIImage>

    var body: some View {
        VStack {
            Text(imageName)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("Chalkduster", size: 15))
                .foregroundStyle(.black)
                .shadow(color: Color.white.opacity(0.8), radius: 2, x: 1, y: 1)
            
            CachedAssetImage(imageName: imageName, cache: cache)
                .frame(width: 200, height: 200)
        }
    }
}
