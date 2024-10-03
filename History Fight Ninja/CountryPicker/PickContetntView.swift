//
//  PickContetntView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 01.10.2024.
//

import SwiftUI

struct PickContetntView: View {
    private let countries: [String] = CountryDataManager.shared.countryNameMap.map { $0.value }
    @State private var tempView: [CountryPickerViewChild] = []
    @State private var shouldPresentContentView = false
    @State private var selectedCountryName: String = ""
    @StateObject private var preloader = ImagePreloader()
    private let heroData = HeroData.shared
    private let mapModel = CountryDataManager.shared
    
    var body: some View {

        GeometryReader { geo in
        ZStack {
            Image("bg1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    if preloader.isLoading {
                        Color.clear.edgesIgnoringSafeArea(.all)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        VStack {
                            CarouseView(views: getChildView(), xDistance: Int(geo.size.width * 1.2), onSelect: { selectedName in
                                selectedCountryName = selectedName
                            })
                            .frame(width: geo.size.height / 4, height: geo.size.height / 4)
                            .padding(.vertical, 80)
                            
                            Button("OK") {
                                
                                prepareForTransition()
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .fullScreenCover(isPresented: $shouldPresentContentView) {
                    ContentView()
                }
            }
            }
        .frame(width: geo.size.width, height: geo.size.height)
//            .ignoresSafeArea()
            .animation(.easeInOut, value: preloader.isLoading)
            .onAppear {
                preloader.preloadImages(countries)
                if selectedCountryName.isEmpty && !countries.isEmpty {
                    selectedCountryName = countries[1]
                    print("Initial country set: \(selectedCountryName)")
                }
            }
        }
    }
    
    private func prepareForTransition() {
        tempView.removeAll() // Clear the array before transition
        heroData.playerCountry = selectedCountryName
        mapModel.updateCountryColor(byName: selectedCountryName, newColor: .green, newPower: heroData.playerPower)
        print("Выбранное изображение: \(selectedCountryName)")
        shouldPresentContentView = true
    }
    
    func getChildView() -> [CountryPickerViewChild] {
        countries.enumerated().map { (index, country) in
            CountryPickerViewChild(id: index, imageName: country, preloader: preloader)
        }
    }
}
