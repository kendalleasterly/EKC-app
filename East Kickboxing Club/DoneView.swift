//
//  DoneView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/2/21.
//

import SwiftUI

struct DoneView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader {proxy in
            
            Text("congrats every thing worked yay")
                .customNavBar(proxy: proxy, title: "Done") {
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
}
