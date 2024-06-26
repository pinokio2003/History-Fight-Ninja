//
//  RestartButtonView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 25.06.2024.
//

import SwiftUI

struct RestartButtonView: View {
    @ObservedObject var heroData = HeroData.shared
    @State var isBouncing: Bool = false
    @State var symbolName: String
    var action : () -> Void
    
    var body: some View {
           ZStack {
               RoundedRectangle(cornerRadius: 32)
                   .fill(
                       LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.4)]),
                                      startPoint: .bottomTrailing,
                                      endPoint: .topLeading)
                   )
                   .frame(width: isBouncing ? 112 : 128,
                          height: isBouncing ? 112 : 128)
                   .overlay(
                       RoundedRectangle(cornerRadius: 32)
                           .stroke(Color.white.opacity(0.3), lineWidth: 2)
                   )
                   .animation(isBouncing ? Animation.easeInOut(duration: 0.6).repeatCount(3, autoreverses: true) : .bouncy, value: isBouncing)

               RoundedRectangle(cornerRadius: 29)
                   .fill(
                       LinearGradient(gradient: Gradient(colors: [Color.black, Color.white.opacity(0.4)]),
                                      startPoint: .top,
                                      endPoint: .trailing)
                   )
                   .frame(width: 89.01, height: 89.01)
                   .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
               
               Image(systemName: symbolName)
                   .resizable()
                   .scaledToFill()
                   .frame(width: 40, height: 40, alignment: .center)
                   .foregroundColor(.white.opacity(0.8))
                   .font(.system(size: 40, weight: .bold))
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
    RestartButtonView(symbolName: "arrow.clockwise", action: {})
}
