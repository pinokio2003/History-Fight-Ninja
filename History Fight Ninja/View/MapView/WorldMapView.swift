//
//  ContentView.swift
//  testMap
//
//  Created by Anatolii Kravchuk on 24.04.2024.
//

import SwiftUI

struct WorldMapView: View {
  
    @State private var scale: CGFloat = 0.5
    @State private var clickedPath: PathData?
    @State private var pathDataArray: [PathData] = []///temp
    ///
//    @StateObject private var herodata = HeroData()
    
    @State var imageWidth: CGFloat = UIScreen.main.bounds.width
    @State var imageHeight: CGFloat = UIScreen.main.bounds.height
    
    @EnvironmentObject var heroData: HeroData
    
    @State private var mapArray: [String: Color] = {
        var map = [String: Color]()
        for country in countryData {
            map[country.countryCode.uppercased()] = country.color.toSwiftUIColor()
        }
        return map
    }()
    
    var body: some View {
        ZStack() {
            ScrollView([.horizontal, .vertical]) {
                InteractiveMap(svgName: "world-low") { pathData in
            
                    let attributes = InteractiveShape.Attributes(
                        strokeWidth: 1.2,
                        strokeColor: .black,
                        background: Color(.sRGB, white: 0.5, opacity: 1),
                        countryColors: mapArray
                    )
                          
                    InteractiveShape(pathData)
                        .initWithAttributes(attributes)
                        .shadow(color: clickedPath?.id == pathData.id ? .white : .clear, radius: 6)
                        .onTapGesture {
                            heroData.isSelected = false
                            if clickedPath?.id == pathData.id {
                                clickedPath = nil
                                
                            } else {
                                clickedPath = pathData
                                heroData.name = pathData.name
                                print(heroData.name)
                                heroData.isSelected = true
                                print("is selected: \(heroData.isSelected)")
                            }
                        }
                        .scaleEffect(clickedPath?.id == pathData.id ? 1.05 : 1)
                        .animation(.easeInOut(duration: 0.2), value: clickedPath?.id)
                        .zIndex(clickedPath?.id == pathData.id ? 2 : 1)
                }
                .frame(width: 1334, height: 750 , alignment: .center)
                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                .scaleEffect(scale)
            }
            .background(Color.blue.opacity(0.5))
            .ignoresSafeArea()
            .environmentObject(heroData)
            
            //MARK: - zoom slider:
            GeometryReader { geometry in
                Slider(value: $scale, in: 0.5...4)
                    .labelsHidden()
                    .frame(width: geometry.size.height / 2, height: geometry.size.width)
                    .position(x: geometry.size.width * 0.85 , y: geometry.size.height / 10)
                
                            if heroData.isSelected {
                                SideMapView()
                                    .frame(width: geometry.size.height * 0.85, alignment: .leading)
                                    .transition(.slide)
                            }
            }
        }
    }
    
    func printAllPathNames() {
        for pathData in pathDataArray {
            print(pathData.name)
        }
    }
}

#Preview {
    WorldMapView()
}
