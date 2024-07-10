//
//  MenuButtonView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 05.07.2024.
//

import SwiftUI

struct MenuButtonView: View {
    @State var show: Bool = false
    
    
    var body: some View {
        ZStack {
            mainButton
                
            if show {
                CanCircleButton(show: $show, Yoffset: 60, sanimation: 0.3, imageName: "Ukraine", action: { print("Button 1 tapped") })
                CanCircleButton(show: $show, Yoffset: 120, sanimation: 0.2, imageName: "Austria", action: { print("Button 2 tapped") })
                CanCircleButton(show: $show, Yoffset: 180, sanimation: 0.1, imageName: "Ukraine", action: { print("Button 3 tapped") })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var mainButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                show.toggle()
            }
        }) {
            ZStack {
                Circle().frame(width: 60)
                    .foregroundColor(.blue.opacity(0.9))
                    .shadow(color: .black, radius: 4, x: 1, y: 3)
                Image("Ukraine")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
            }
        }
//        .offset(x: -120, y: -120)
    }
}

struct CanCircleButton: View {
    @Binding var show: Bool
    var Yoffset: CGFloat
    var sanimation: CGFloat
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle().frame(width: 50)
                    .foregroundColor(.blue.opacity(0.9))
                    .shadow(color: .black, radius: 4, x: 1, y: 3)
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            }
        }
        .offset(y: show ? Yoffset : 0)
        .opacity(show ? 1 : 0)
        .animation(Animation.spring(response: 0.5, dampingFraction: 0.6)
            .delay(show ? sanimation : 0), value: show)
    }
}

#Preview {
    MenuButtonView()
}
