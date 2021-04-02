//
//  Payment.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/1/21.
//

import SwiftUI

struct Payment: View {
    
    @EnvironmentObject var model: BookingModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader{ proxy in
            
            VStack {
                Text("Payment")
                
                ButtonView(text: "Done") {
                    
                }
            }.customNavBar(proxy: proxy, title: "Payment") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
