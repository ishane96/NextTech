//
//  TextModifier.swift
//  Next_Tech
//
//  Created by Achintha kahawalage on 2023-05-12.
//

import SwiftUI

class TextModifier {
    
    struct Regular12x8D8C91: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.system(size: 13.0, weight: .regular, design: .rounded))
                .foregroundColor(Color("blackGray"))
        }
    }
}
