//
//  MiddleVsText.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 30.05.2024.
//

import SwiftUI

struct MiddleVsText: View {
    
    let title = "VS"
    var delayStep = 0.5
    @State var isShow: Bool = false
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<title.count, id: \.self) { index in
                Text(String(title[title.index(title.startIndex,
                                              offsetBy: index)]))
                    .font(.custom("Chalkduster", size: 150))
                    .foregroundColor(isShow ? .red : .clear)
                    .offset(y: isShow ? UIScreen.main.bounds.height * 0.05 : UIScreen.main.bounds.height * -1)
                    .animation(.easeInOut(duration: 0.3).delay(Double(index) * delayStep), value: isShow)
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                isShow.toggle()
            }
        }
    }
}

#Preview {
    MiddleVsText()
}
