//
//  Payment.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/1/21.
//

import SwiftUI

struct Payment: View {
    
    //i ask for the product
    var product: Product?
    
    @EnvironmentObject var bookingModel: BookingModel
    @EnvironmentObject var accountModel: AccountModel
    var productsModel = ProductsModel()
    @Environment(\.presentationMode) var presentationMode
    
    init(_ product: Product) {
        self.product = product
    }
    
    init() {
        self.product = nil
    }
    
    var body: some View {
        GeometryReader{ proxy in
            
            VStack {
                
                VStack {
                    
                    Text("Enter your payment details")
                        
                
                    
                    if product == nil {
                        //pay for a booking
                        
                        ButtonView(text: "Done", destination: AnyView(DoneView())) {
                            bookingModel.bookClass()
                        }
                        
                    } else {
                        //pay for a product
                        
                        ButtonView(text: "Done", destination: AnyView(DoneView())) {
                            if product!.id != "membership" {
                                productsModel.addCreditsFrom(product: product!)
                            } else {
                                productsModel.makeMember()
                            }
                        }
                        
                    }
                }.carded()
            }.padding()
            .customNavBar(proxy: proxy, title: "Payment") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
