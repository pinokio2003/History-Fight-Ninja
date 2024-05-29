//
//  Field.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 18.05.2024.
//

import SwiftUI

struct AttacButton: View {
    @State private var isPushing: Bool = false
    @StateObject var heroData = HeroData.shared
    @StateObject var mapsDict = CountryDataManager.shared
    
    let centerCircleStart: Color = Color(red: 241 / 255, green: 195 / 255, blue: 2 / 255)
    let centerCircleEnd: Color = Color(red: 241 / 255, green: 171 / 255, blue: 2 / 255)
    let secondStart: Color = Color(red: 215 / 255, green: 87 / 255, blue: 97 / 255)
    let secondEnd: Color = Color(red: 197 / 255, green: 7 / 255, blue: 24 / 255)
    let thirdStart: Color = Color(red: 225 / 255, green: 104 / 255, blue: 114 / 255)
    let innerShadowColor: Color = Color(red: 132 / 255, green: 30 / 255, blue: 30 / 255)
    let lascCircleStart: Color = Color(red: 251 / 255, green: 40 / 255, blue: 57 / 255)
    let lascCircleEnd: Color = Color(red: 116 / 255, green: 3 / 255, blue: 13 / 255)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(
                    LinearGradient(colors: [centerCircleStart, centerCircleEnd],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .frame(width: 80, height: 80)
            //second:
            RoundedRectangle(cornerRadius: 50)
                .fill(
                    LinearGradient(colors: isPushing ?[secondEnd, secondStart] :  [secondStart, secondEnd],
                               startPoint: .top,
                               endPoint: .bottom)
                )
                .opacity(0.7)
                .blur(radius: 4)
                .frame(width: isPushing ? 67 : 73,
                       height: isPushing ? 67 : 73)
            //third:
            RoundedRectangle(cornerRadius: 50)
                .fill(
                    LinearGradient(colors: isPushing ?  [secondEnd, secondEnd] : [thirdStart, secondEnd],
                               startPoint: .top,
                               endPoint: .bottom)
                )
                .frame(width: isPushing ? 67 : 73,
                       height: isPushing ? 67 : 73)
                .shadow(color: Color.black.opacity(0.3), radius: 12, x: 2, y: 7) // Внешняя тень
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.black.opacity(0.5), lineWidth: 3)
                                    .blur(radius: isPushing ? 17: 7)
                                    .offset(x: 0, y: 4)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 50)
                                            .fill(innerShadowColor)
                                    )
                            )
            RoundedRectangle(cornerRadius: 50)
                .fill(
                    LinearGradient(colors: isPushing ? [lascCircleEnd, lascCircleEnd] : [lascCircleStart, lascCircleEnd] ,
                               startPoint: .top,
                               endPoint: .bottom)
                )
                .opacity(0.7)
                .frame(width: isPushing ? 65 : 67,
                       height: isPushing ? 65 : 67)
            
            Blick()
                .fill(
                    LinearGradient(colors: [Color.white, lascCircleStart],
                                   startPoint: .bottomLeading,
                                   endPoint: .topTrailing)
                )
                .frame(width: isPushing ? 9 : 13,
                       height: isPushing ? 9 : 13)
                .offset(x: -17.0, y: -17.0)
            
            Text("Attack")
                .font(.custom("Chalkduster", size: isPushing ? 14 : 15))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.5), radius:  2, x: 1, y: 1)
        } 
       
        .onTapGesture {
            guard !isPushing else { return }
            withAnimation(.easeInOut(duration: 0.2)) {
                isPushing = true
                heroData.enemyName = mapsDict.countryNameMap[heroData.name]!
//                print("Test name: \(heroData.enemyName)")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isPushing = false
                    heroData.isFightStartButton = true
                }
            }
        }
        .environmentObject(heroData)
        .environmentObject(mapsDict)
    }
    //blick
    struct Blick: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0.98089*width, y: 0.03632*height))
            path.addCurve(to: CGPoint(x: 0.52096*width, y: 0.44284*height), control1: CGPoint(x: 1.03324*width, y: 0.12541*height), control2: CGPoint(x: 0.77907*width, y: 0.22899*height))
            path.addCurve(to: CGPoint(x: 0.05919*width, y: 0.97628*height), control1: CGPoint(x: 0.26286*width, y: 0.65668*height), control2: CGPoint(x: 0.11154*width, y: 1.06537*height))
            path.addCurve(to: CGPoint(x: 0.41877*width, y: 0.2622*height), control1: CGPoint(x: 0.00685*width, y: 0.88718*height), control2: CGPoint(x: 0.16067*width, y: 0.47604*height))
            path.addCurve(to: CGPoint(x: 0.98089*width, y: 0.03632*height), control1: CGPoint(x: 0.67688*width, y: 0.04835*height), control2: CGPoint(x: 0.92855*width, y: -0.05278*height))
            path.closeSubpath()
            return path
        }
    }
}

#Preview {
    AttacButton()
}
