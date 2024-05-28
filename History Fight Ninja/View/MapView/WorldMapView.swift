//
//  ContentView.swift
//  testMap
//
//  Created by Anatolii Kravchuk on 24.04.2024.
//

import SwiftUI

struct WorldMapView: View {
  
    @State private var clickedPath: PathData?
    @State private var pathDataArray: [PathData] = []///temp
    ///Gesture:
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lasteStoredOffset: CGSize = .zero
    @GestureState private var isInteracting: Bool = false
    //Screen size:
    @State var imageWidth: CGFloat = UIScreen.main.bounds.width
    @State var imageHeight: CGFloat = UIScreen.main.bounds.height
    
    @EnvironmentObject var heroData: HeroData
    var countryManager = CountryDataManager.shared

    var body: some View {
        ZStack() {    
            GeometryReader { geo in
                let size = geo.size             
//View MAP:
                InteractiveMap(svgName: "world-low") { pathData in
                    let attributes = InteractiveShape.Attributes(
                        strokeWidth: 1.2,
                        strokeColor: .black,
                        background: Color(.sRGB, white: 0.5, opacity: 1),
                        countryColors: countryManager.colorMap
                    )
//Countries:
                    InteractiveShape(pathData)
                        .initWithAttributes(attributes)
                        .shadow(color: clickedPath?.id == pathData.id ? .white : .clear, radius: 6)
                        .onTapGesture {
                            
                            heroData.isCountrySelected = false
                            if clickedPath?.id == pathData.id && heroData.isCountrySelected == false {
                                clickedPath = nil
                            } else {
                                clickedPath = pathData
                                heroData.name = pathData.name
                                print(heroData.name)
                                heroData.isCountrySelected = true
                                print("is selected: \(heroData.isCountrySelected)")
                            }
                        }
                        .scaleEffect(clickedPath?.id == pathData.id ? 1.05 : 1)
                        .animation(.easeInOut(duration: 0.2), value: clickedPath?.id)
                        .zIndex(clickedPath?.id == pathData.id ? 2 : 1)
                    
                }
                .aspectRatio(contentMode: .fill)
                .overlay {
                    GeometryReader { proxy in
                        let rect = proxy.frame(in: .named("MAPSCALES"))
                        Color.clear
                            .onChange(of: isInteracting) { newValue in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    if rect.minX > 0 {
                                        offset.width = (offset.width - rect.minX)
                                        haptics(.medium)
                                    }
                                    if rect.minY > 0 {
                                        offset.height = (offset.height - rect.minY)
                                        haptics(.medium)
                                    }
                                    if rect.maxX < size.width {
                                        offset.width = (rect.minX - offset.width)
                                        haptics(.medium)
                                    }
                                    if rect.maxY < size.height {
                                        offset.height = (rect.minY - offset.height)
                                        haptics(.medium)
                                    }
                                }
                                
                                if !newValue {
                                    lasteStoredOffset = offset
                                }
                            }
                    }
                }
                .background(Color.blue.opacity(0.001))
            }
       
                //Scale gesture:
                .scaleEffect(scale)
                .offset(offset)
                .coordinateSpace(name: "MAPSCALES")
                .gesture(
                    DragGesture()
                        .updating($isInteracting, body: { _, out, _ in
                            out = true
                        }).onChanged({ value in
                            let translation = value.translation
                            offset = CGSize(width: translation.width + lasteStoredOffset.width,
                                            height: translation.height + lasteStoredOffset.height)
                        })
                )
                .gesture(
                MagnificationGesture()
                    .updating($isInteracting, body: {_, out, _ in
                        out = true
                    }).onChanged({ value in
                        let updatedScale = value + lastScale
                        scale = (updatedScale < 1 ? 1 : updatedScale)
                    }).onEnded({ value in
                        withAnimation(.easeInOut(duration: 0.2)){
                            if scale < 1 {
                                scale = 1
                                lastScale = 0
                            } else {
                                lastScale = scale - 1
                            }
                        }
                    })
                )
                .frame(width: imageWidth, height: imageHeight)

        }
        .onAppear {
            countryManager.addColorArray()
        }
        .background(Color.blue.opacity(0.5))
    }
    
    func printAllPathNames() {
        for pathData in pathDataArray {
            print(pathData.name)
        }
    }
    
    func haptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

#Preview {
    WorldMapView()
}
