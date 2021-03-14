//
//  ProductsView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import SwiftUI

struct ProductsView: View {
    
    let colors: [UIColor] = [.label, .secondaryLabel, .tertiaryLabel, .quaternaryLabel]
    
    var body: some View {
        VStack {
            
            Rectangle().foregroundColor(Color(colors[0]))
            
            Rectangle().foregroundColor(Color(colors[1]))
            
            Rectangle().foregroundColor(Color(colors[2]))
            
            Rectangle().foregroundColor(Color(colors[3]))
            
        }
    }
}
