//
//  View+Extension.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI

extension View {
    
    func centered() -> some View {
        return self.modifier(CenteredModifier())
    }
    
}

struct CenteredModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
