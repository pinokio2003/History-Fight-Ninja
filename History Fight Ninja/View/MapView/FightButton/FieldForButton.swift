
import SwiftUI

struct FieldForButton: View {
    //colors:
    //first rectangle:
    let firstStartColor: Color = Color(red: 240 / 255, green: 208 / 255, blue: 2 / 255)
    let firstEndColor: Color = Color(red: 240 / 255, green: 155 / 255, blue: 1 / 255)
    //second rect:
    let secondStartColor: Color = Color(red: 241 / 255, green: 203 / 255, blue: 3 / 255)
    let secondEndColor: Color = Color(red: 241 / 255, green: 159 / 255, blue: 2 / 255)
    //third rect:
    let thirdStartColor: Color = Color(red: 241 / 255, green: 203 / 255, blue: 3 / 255)
    let thirdEndColor: Color = Color(red: 249 / 255, green: 159 / 255, blue: 2 / 255)
    //bolt
    let boltStartColor: Color = Color(red: 168 / 255, green: 168 / 255, blue: 168 / 255)
    let boltCenterColor: Color = Color(red: 248 / 255, green: 246 / 255, blue: 246 / 255)
    let boltEndColor: Color = Color(red: 90 / 255, green: 89 / 255, blue: 92 / 255)
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(colors: [firstStartColor, firstEndColor], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 155, height: 155)
            Rectangle()
                .frame(width: 10, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: 60, y: 60)
            
            Rectangle()
                .frame(width: 43.19, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: 50, y: 50)
            
            Rectangle()
                .frame(width: 75, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: 40, y: 40)
            
            Rectangle()
                .frame(width: 100, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: 30, y: 30)
            
            Rectangle()
                .frame(width: 125, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: 20, y: 20)
            
            Rectangle()
                .frame(width: 150, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: 10, y: 10)
            
            Rectangle()
                .frame(width: 170, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: 0, y: 0)
            
            Rectangle()
                .frame(width: 150, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: -10, y: -10)
            
            Rectangle()
                .frame(width: 125, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: -20, y: -20)
            
            Rectangle()
                .frame(width: 100, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: -30, y: -30)
            
            Rectangle()
                .frame(width: 75, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: -40, y: -40)
            
            Rectangle()
                .frame(width: 43.19, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: -50, y: -50)
            
            Rectangle()
                .frame(width: 10, height: 8)
                .rotationEffect(.degrees(132))
                .offset(x: -60, y: -60)
            
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(colors: [secondStartColor, secondEndColor], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 8, height: 135)
                .offset(x: 64, y: 0)
            
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(colors: [secondStartColor, secondEndColor], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 8, height: 135)
                .offset(x: -64, y: 0)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    LinearGradient(colors: [thirdStartColor], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 135, height: 8)
                .offset(x: 0, y: -67)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    LinearGradient(colors: [secondEndColor], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 135, height: 8)
                .offset(x: 0, y: 68)
            //Bolt:
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [secondEndColor], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 18, height: 18)
                .offset(x: -52, y: 60)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [boltStartColor, boltCenterColor, boltEndColor],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .rotationEffect(.degrees(-25))
                .frame(width: 6, height: 6)
                .offset(x: -52, y: 60)
            
            Rectangle()
                .frame(width: 0.6, height: 3)
                .offset(x: -52, y: 60)
            
            Rectangle()
                .frame(width: 3, height: 0.6)
                .offset(x: -52, y: 60)
            //second bolt
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [secondEndColor], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 18, height: 18)
                .offset(x: 55, y: 60)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [boltStartColor, boltCenterColor, boltEndColor],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .rotationEffect(.degrees(-25))
                .frame(width: 6, height: 6)
                .offset(x: 55, y: 60)
            
            Rectangle()
                .frame(width: 0.6, height: 3)
                .offset(x: 55, y: 60)
            
            Rectangle()
                .frame(width: 3, height: 0.6)
                .offset(x: 55, y: 60)
            
            //third bolt
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [secondStartColor], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 18, height: 18)
                .offset(x: -52, y: -60)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [boltStartColor, boltCenterColor, boltEndColor],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .rotationEffect(.degrees(-25))
                .frame(width: 6, height: 6)
                .offset(x: -52, y: -60)
            
            Rectangle()
                .frame(width: 0.6, height: 3)
                .offset(x: -52, y: -60)
            
            Rectangle()
                .frame(width: 3, height: 0.6)
                .offset(x: -52, y: -60)
            
            //firth
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [secondStartColor], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 18, height: 18)
                .offset(x: 52, y: -60)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(colors: [boltStartColor, boltCenterColor, boltEndColor],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .rotationEffect(.degrees(-25))
                .frame(width: 6, height: 6)
                .offset(x: 52, y: -60)
            
            Rectangle()
                .frame(width: 0.6, height: 3)
                .offset(x: 52, y: -60)
            
            Rectangle()
                .frame(width: 3, height: 0.6)
                .offset(x: 52, y: -60)
            

        }
    }
}

#Preview {
    FieldForButton()
}


