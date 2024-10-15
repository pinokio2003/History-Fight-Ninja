//
//  MapRenderer.swift
//  InteractiveMap
//
//  Created by GrandSir on 14.09.2022.
//

import SwiftUI

public struct InteractiveShape : Shape {
    let pathData : PathData
    
    public func path(in rect: CGRect) -> Path {
        let path = executeCommand(svgData : pathData, rect: rect)
        return path
    }
    
    public init (_ pathData: PathData) {
        self.pathData = pathData
    }
}


/// Default attributes for Map

public struct Attributes {
    public var strokeWidth: Double
    public var strokeColor: Color
    public var background: Color
    public var countryColors: [String: Color] // Добавляем свойство для хранения цветов стран
    
    public init(
        strokeWidth: Double = 1.2,
        strokeColor: Color = .black,
        background: Color = Color(.sRGB, white: 0.5, opacity: 1),
        countryColors: [String: Color] = [:] // Инициализируем пустым словарем
    ) {
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
        self.background = background
        self.countryColors = countryColors
    }
}


public struct InteractiveMap<Content> : View where Content : View {
    /// name of the SVG, can be written with or without file extension
    let svgName : String
    
    /// Closure that is needed to customize the map,
    var content: ((_ pathData: PathData) -> Content)
    
    
    public init(svgName: String, @ViewBuilder content: @escaping (_ pathData: PathData) -> Content) {
        self.svgName = svgName
        self.content = content
    }

    @State private var width : CGFloat = .zero
    @State private var height : CGFloat = .zero

    @State private var pathData = [PathData]()
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                if !pathData.isEmpty {
                    ForEach(pathData) { pathData in
                        content(pathData)
                        
                    }
                    
                }
            }
//            .scaledToFill()
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                let parser = MapParser(svgName: svgName, size: geo.size)
                pathData = parser.pathDatas
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//        .frame(width: 2000, height: 2000, alignment: .center)
    }
}


extension InteractiveShape {

    public func initWithAttributes() -> some View {
        let attributes = Attributes()
        return self
            .stroke(attributes.strokeColor, lineWidth: attributes.strokeWidth)
            .background(self.fill(attributes.background))
    }
    //MARK: - additional code for colors
    public struct Attributes {
        public var strokeWidth: Double
        public var strokeColor: Color
        public var background: Color
        public var countryColors: [String: Color] // Словарь для хранения цветов стран
        
        public init(
            strokeWidth: Double = 1.2,
            strokeColor: Color = .black,
            background: Color = Color(.sRGB, white: 0.5, opacity: 1),
            countryColors: [String: Color] = [:] // Инициализация пустого словаря
        ) {
            self.strokeWidth = strokeWidth
            self.strokeColor = strokeColor
            self.background = background
            self.countryColors = countryColors
        }
    }
}

extension InteractiveShape {
    public func initWithAttributes(_ attributes: Attributes) -> some View {
        self
            .stroke(attributes.strokeColor, lineWidth: attributes.strokeWidth)
            .background(self.fill(attributes.countryColors[pathData.name] ?? .gray))
    }
}
