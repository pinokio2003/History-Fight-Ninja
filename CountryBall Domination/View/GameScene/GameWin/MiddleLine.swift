//
//  MiddleLine.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 03.07.2024.
//

import SwiftUI

struct MiddleLine: View {
    @State var lineHeight: CGFloat = 2
    @State var lineWidth: CGFloat = 5
    @State var trigger: Bool = false
    var newLineWidth: CGFloat = 5
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: lineWidth, height: lineHeight)
                .animation(.easeInOut(duration: 2), value: trigger)
                .foregroundColor(.white)
        }
        .onAppear {
            trigger = true
            lineWidth += newLineWidth
        }
    }
}

#Preview {
    MiddleLine()
}
