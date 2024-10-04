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
                            Spacer()
                            Text(selectedCountryName)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.custom("Chalkduster", size: geo.size.height / 15))
                                .foregroundStyle(.white)
                                .shadow(color: Color.black.opacity(0.8), radius: 2, x: 1, y: 1)
                      
                                
                            Spacer()
                            CarouseView(views: getChildView(), xDistance: Int(geo.size.width * 1.2), onSelect: { selectedName in
                                selectedCountryName = selectedName
                            })
                            .frame(width: geo.size.height / 4, height: geo.size.height / 4)
//                            .padding(.vertical, 40)
                            Spacer()
                            Button {
                                prepareForTransition()
                            } label: {
                                Text("OK")
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.custom("Chalkduster", size: 35))
                                    .foregroundStyle(.red)
                                    .shadow(color: Color.black.opacity(0.8), radius: 2, x: 1, y: 1)
                                    
                            }
                            Spacer()
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
        .opacity(mapModel.opacity)
//            .ignoresSafeArea()
            .animation(.easeInOut, value: preloader.isLoading)
            .onAppear {
                preloader.preloadImages(countries)
                if selectedCountryName.isEmpty && !countries.isEmpty {
                    selectedCountryName = countries[1]
                    fadeIn()
                }
            }
        }
    }
    
    private func fadeIn() {
        withAnimation(.easeIn(duration: 0.5)) {
            mapModel.opacity = 1.0
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
