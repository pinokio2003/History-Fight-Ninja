//
//  SkillDetailView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 22.07.2024.
//

import SwiftUI

struct SkillPopoverView: View {
    let skill: SkillModel
    @Binding var isPresented: Bool
    let canUnlock: Bool
    let onUnlock: () -> Void
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ZStack {
            Image(skill.imageName)
                .resizable()
                .scaledToFill()
                .blur(radius: 5)
                .clipped()
                .frame(width: sizeClass == .compact ? nil : 300, height: sizeClass == .compact ? nil : 400)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
     
                VStack(spacing: 15) {
                    
                    ZStack {
                        HStack {
                            Spacer()
                            Text(skill.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                        }
                        HStack {    
                            Spacer()
                            Button(action: {
                                isPresented = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.black)
                                    .font(.title)
                            }
                        }
                    }
    
                    Image(skill.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .background(Color.gray.opacity(0.8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .cornerRadius(10)
                    
                    Text(skill.description)
                        .font(.custom("Chalkduster", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
//                        .lineLimit(4)
                        .frame(maxWidth: 250)
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: 250, height: 1)
                    
                    Text("Cost: \(skill.cost)")
                        .font(.headline)
                    
                    HStack {
                        if canUnlock {
                            Button("  Buy   ") {
                                onUnlock()
                                skill.action()
                                isPresented = false
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        }
//                        Spacer()
                    }
                }
                .frame(minWidth: 0)
                .padding(.all, 5)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                        .shadow(color: .black, radius: 1, x: -1, y: 1)
                )
                
                .padding()
                .frame(width: 300, height: 400)
            }

        }
        .padding()
        .frame(width: sizeClass == .compact ? nil : 300, height: sizeClass == .compact ? nil : 400)
    }
}

struct SkillPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        SkillPopoverView(
            skill: exampleSkill,
            isPresented: .constant(true),
            canUnlock: true,
            onUnlock: {}
        )
        .previewLayout(.sizeThatFits)
        .environment(\.horizontalSizeClass, .compact)
    }
}
