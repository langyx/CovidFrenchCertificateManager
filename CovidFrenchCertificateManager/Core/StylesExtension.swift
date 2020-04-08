//
//  StylesExtension.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import Foundation
import SwiftUI



extension Font {
    static let headerTitleFont = Font.system(size: 25, weight: .heavy, design: .rounded)
    static let subHeaderTitle = Font.system(size: 20, weight: .medium, design: .rounded)
    static let corp = Font.system(size: 15, weight: .medium, design: .rounded)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    static let darkStart = Color(red: 70 / 255, green: 80 / 255, blue: 200 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
    
}

struct TextFieldNeumorphic: TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(7)
            .background(NeoBackground(isHighlighted: false, shape: RoundedRectangle(cornerRadius: 10)))
    }
}


struct NeoBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        
        Group{
            if self.isHighlighted {
                shape
                    .fill(Color.offWhite)
                    .overlay(
                        shape
                            .stroke(Color.offWhite, lineWidth: 1))
                    .overlay(
                        shape
                            .stroke(Color.gray, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(shape.fill(LinearGradient(Color.black, Color.clear)))
                )
                    .overlay(shape
                        .stroke(Color.white, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask(shape
                            .fill(LinearGradient(Color.clear, Color.black))))
            }else{
                shape
                    .fill(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        }
        
        
    }
}
