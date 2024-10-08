//
//  CustomAlert.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 08.10.2024.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var showAlert: Bool // Привязка состояния показа
    private let heroData = HeroData.shared
    
    var body: some View {
        ZStack {
            
            CustomAlert(showAlert: $showAlert, color: Color.clear) {
                ZStack {
                    Spacer()
                    Image("alertBall")
                        .resizable()
                        .frame(width: 150, height: 120)
                        .blur(radius: 3)
                        .offset(y: -150)
                    
                    Image("alertBall")
                        .resizable()
                        .frame(width: 150, height: 120)
                        .offset(y: -150)
                    VStack {
                        Text("Do you really want to start new game?")
                            .font(.system(size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        Capsule()
                            .frame(height: 1)
                            .foregroundColor(.orange)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        
                        Text("All data will be lost!")
                            .font(.system(size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack {
                            StartButton(action: presentPickContetntView,
                                        text: "OK",
                                        isUpBubble: .random())
                            .frame(width: 150, height: 50, alignment: .center)
                            
                            StartButton(action: showAllertToggle,
                                        text: "Cancel",
                                        isUpBubble: .random())
                            .frame(width: 150, height: 50, alignment: .center)
                            
                        }
                        
                    }
                }
            }
            
        }
    }
    
    func showAllertToggle() {
        withAnimation(.spring(duration: 0.5, bounce: 0.45)) {
            showAlert.toggle()
        }
    }
    
   private func presentPickContetntView()  {
        heroData.clearUserDefaults()
        presentContentView(with: PickContetntView())
    }
}


// MARK: - custom alert component
struct CustomAlert<Content: View>: View {
    @Binding var showAlert: Bool
    var color: Color = Color.gray.opacity(0.5)
    
    let content: Content
    
    init(showAlert: Binding<Bool>, color: Color, @ViewBuilder content: () -> Content) {
        self._showAlert = showAlert
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        if showAlert {
            ZStack {
                Color.black
                    .opacity(showAlert ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .cornerRadius(15)
                
                ZStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(color).opacity(0.2)
                            .frame(width: 250, height: 150)
                            .blur(radius: 3)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(color).opacity(0.2)
                            .frame(width: 250, height: 150)
                    }
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0.0, y: 0.0)
                    
                    VStack{
                        content
                    }
                }
                .opacity(showAlert ? 1 : 0)
                .scaleEffect(showAlert ? 1 : 0)
            }
            .frame(width: 250, height: 250, alignment: .center)
            
            .edgesIgnoringSafeArea(.all)
        }
    }
}
