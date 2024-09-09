//
//  ReturnButton.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 24.07.2024.
//

import SwiftUI

struct ReturnButton: View {

        @ObservedObject var heroData = HeroData.shared
        @State private var isBouncing: Bool = false
        @State var symbolName: String
        var action : () -> Void
        
        var body: some View {
               ZStack {
                   RoundedRectangle(cornerRadius: 30)
                       .fill(
                           LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.4)]),
                                          startPoint: .bottomTrailing,
                                          endPoint: .topLeading)
                       )
                       .frame(width: isBouncing ? 56 : 64,
                              height: isBouncing ? 56 : 64)
                       .overlay(
                           RoundedRectangle(cornerRadius: 30)
                               .stroke(Color.white.opacity(0.3), lineWidth: 2)
                       )
                       .animation(isBouncing ? Animation.easeInOut(duration: 0.6).repeatCount(3, autoreverses: true) : .bouncy, value: isBouncing)

                   RoundedRectangle(cornerRadius: 30 )
                       .fill(
                           LinearGradient(gradient: Gradient(colors: [Color.black, Color.white.opacity(0.4)]),
                                          startPoint: .top,
                                          endPoint: .trailing)
                       )
                       .frame(width: 45, height: 45)
                       .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                   
                   Image(systemName: symbolName)
                       .resizable()
                       .scaledToFill()
                       .frame(width: 40, height: 40, alignment: .center)
                       .foregroundColor(.white.opacity(0.8))
                       .font(.system(size: 40 , weight: .bold))
                       .scaleEffect(isBouncing ? 1.2 : 1)
                       .animation(isBouncing ? Animation.easeInOut(duration: 0.3).repeatCount(3, autoreverses: true) : .default, value: isBouncing)
                       
               }

               .onTapGesture {
                   heroData.isDisabledSkill.toggle()
                   isBouncing = true
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                       isBouncing = false
    //                   heroData.isRestartPushing.toggle()
                       action()
                   }
               }
           }
       }

    #Preview {
        RestartButtonView(symbolName: "globe", action: {}, sizeValue: 32)
    }
