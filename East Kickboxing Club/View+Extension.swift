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
    
    func leading() -> some View {
        return self.modifier(LeadingModifier())
    }
    
    func trailing() -> some View {
        return self.modifier(TrailingModifier())
    }
    
    func carded() -> some View {
        return self.modifier(CardedModifier())
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

struct LeadingModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        HStack {
            content
            Spacer()
        }
    }
}

struct TrailingModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        HStack {
            Spacer()
            content
        }
    }
}

struct CardedModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        content
            .padding(.horizontal, 32)
            .padding(.vertical, 24)
            .background(Color.secondaryBackground)
            .cornerRadius(16.0)
//            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.20000000298023224)), radius:40, x:0, y:20)
        
    }
}
