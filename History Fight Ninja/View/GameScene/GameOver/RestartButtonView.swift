//
//  RestartButtonView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 25.06.2024.
//

import SwiftUI

struct RestartButtonView: View {
    @ObservedObject var heroData = HeroData.shared
    @State private var isBouncing: Bool = false
    @State var symbolName: String
    var action : () -> Void
    @State var sizeValue: Double // 32
    
    var body: some View {
           ZStack {
               RoundedRectangle(cornerRadius: sizeValue) // 32
                   .fill(
                       LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.4)]),
                                      startPoint: .bottomTrailing,
                                      endPoint: .topLeading)
                   )
                   .frame(width: sizeValue * (isBouncing ? 3.5 : 4),
                          height: sizeValue * (isBouncing ? 3.5 : 4))
                   .overlay(
                       RoundedRectangle(cornerRadius: sizeValue)
                           .stroke(Color.white.opacity(0.3), lineWidth: 2)
                   )
                   .animation(isBouncing ? Animation.easeInOut(duration: 0.6).repeatCount(3, autoreverses: true) : .bouncy, value: isBouncing)

               RoundedRectangle(cornerRadius: sizeValue * 0.9)
                   .fill(
                       LinearGradient(gradient: Gradient(colors: [Color.black, Color.white.opacity(0.4)]),
                                      startPoint: .top,
                                      endPoint: .trailing)
                   )
                   .frame(width: sizeValue * 2.78, height: sizeValue * 2.78)
                   .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
               
               Image(systemName: symbolName)
                   .resizable()
                   .scaledToFill()
                   .frame(width: sizeValue * 1.25, height: sizeValue * 1.25, alignment: .center)
                   .foregroundColor(.white.opacity(0.8))
                   .font(.system(size: sizeValue * 1.25, weight: .bold))
                   .scaleEffect(isBouncing ? 1.2 : 1)
                   .animation(isBouncing ? Animation.easeInOut(duration: 0.6).repeatCount(3, autoreverses: true) : .default, value: isBouncing)
                   
           }

           .onTapGesture {
               heroData.isDisabled.toggle()
               isBouncing = true
               DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   isBouncing = false
//                   heroData.isRestartPushing.toggle()
                   action()
               }
           }
       }
   }

#Preview {
    RestartButtonView(symbolName: "arrow.clockwise", action: {}, sizeValue: 32)
}
