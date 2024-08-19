//
//  SkillConnectionView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 19.08.2024.
//

import SwiftUI

struct SkillConnectionView: View {
    let from: CGPoint
    let to: CGPoint
    let offset: CGFloat = 58 // Увеличим отступ для большего эффекта

    var body: some View {
        Path { path in
            let dx = to.x - from.x
            let dy = to.y - from.y
            let distance = sqrt(dx*dx + dy*dy)
            
            // First and last point
            let startRatio = offset / distance
            let endRatio = (distance - offset) / distance

            let startX = from.x + dx * startRatio
            let startY = from.y + dy * startRatio
            let endX = from.x + dx * endRatio
            let endY = from.y + dy * endRatio

            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: endX, y: endY))
        }
        .stroke(innerPurple, lineWidth: 2)
        .shadow(color: .white, radius: 3, x: 1, y: 1)
        
    }
}

