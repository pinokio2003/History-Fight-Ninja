//
//  CarouseView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 28.09.2024.
//

import SwiftUI

struct CarouseView: View {
    @State private var snappedItem = 0.0
    @State private var druggingItem = 1.0
    @State private var activeIndex: Int = 0
    
    var views: [CountryPickerViewChild]
    var xDistance: Int //920
    var onSelect: (String) -> Void // Передаём выбранное изображение
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(views, id: \.id) { view in
                    view
                        .scaleEffect(1.2 - abs(distance(view.id)) * 0.45)
                        .opacity(1.0 - abs(distance(view.id)) * 0.3)
                        .offset(x: getOffset(view.id), y: 0)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        druggingItem = snappedItem + value.translation.width / 100
                    }
                    .onEnded { value in
                        withAnimation {
                            druggingItem = snappedItem + value.predictedEndTranslation.width / 100
                            druggingItem = round(druggingItem).remainder(dividingBy: Double(views.count))
                            snappedItem = druggingItem
                            self.activeIndex = views.count + Int(druggingItem)
                            if self.activeIndex > views.count || Int(druggingItem) >= 0 {
                                self.activeIndex = Int(druggingItem)
                            }
                            let selectedImageName = views[activeIndex % views.count].imageName
                            onSelect(selectedImageName) // Передаём название изображения
                        }
                    }
            )
        }
    }
    
    func distance(_ item: Int) -> Double {
        return (druggingItem - Double(item).remainder(dividingBy: Double(views.count)))
    }
    
    func getOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2.2 / Double(views.count) * distance(item)
        return sin(angle) * Double(xDistance * 4)
    }
}
