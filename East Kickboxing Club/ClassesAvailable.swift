//
//  ClassesAvailable.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/1/21.
//

import SwiftUI

struct ClassesAvailable: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack {
                Text("classes available")
            }.customNavBar(proxy: proxy, title: "Use an Available Credit") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

