//
//  PickContetntView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 01.10.2024.
//

import SwiftUI

struct PickContetntView: View {
    private let countriesName: [String] = CountryDataManager.shared.countryNameMap.map { $0.value }
    @State private var tempView: [CountryPickerViewChild] = []
    @State private var shouldPresentContentView = false
    @State private var selectedCountryName: String = "" // Для хранения выбранного изображения
    let imageCache = NSCache<NSString, UIImage>()

    var body: some View {
        ZStack {
            Image("bg1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    VStack {
                        CarouseView(views: getChildView(), onSelect: { selectedName in
                            selectedCountryName = selectedName
                        })
                    }
                }
                Button("Подтвердить выбор") {
                    prepareForTransition()
                }
            }
            
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $shouldPresentContentView) {
                ContentView()
            }
        }
        .ignoresSafeArea()
    }
    
    private func prepareForTransition() {
        tempView.removeAll() // Clear the array before transition
        print("Выбранное изображение: \(selectedCountryName)")
        shouldPresentContentView = true
    }
    
    func getChildView() -> [CountryPickerViewChild] {
        
        countriesName.enumerated().map { (index, country) in
            CountryPickerViewChild(id: index, imageName: country, cache: imageCache)
        }
    }
}
