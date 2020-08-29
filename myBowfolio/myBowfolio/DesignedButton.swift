//
//  DesignedButton.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct DesignedButton: View {
    var buttonText: String
    var body: some View {
        
        Text(buttonText)
            .foregroundColor(Color.black)
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.8491371274, green: 0.9115262032, blue: 0.9936997294, alpha: 1))
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .foregroundColor(Color.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8491371274, green: 0.9115262032, blue: 0.9936997294, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                        .blur(radius: 2)
                        .padding(2)
                }
        )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white, lineWidth: 2)
        )
            .cornerRadius(25)
            .shadow(color: Color(#colorLiteral(red: 0.786849916, green: 0.8632053137, blue: 1, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color.white, radius: 20, x: -20, y: -20)
        
    }
}

struct DesignedButton_Previews: PreviewProvider {
    static var previews: some View {
        DesignedButton(buttonText: "LOGIN")
    }
}
