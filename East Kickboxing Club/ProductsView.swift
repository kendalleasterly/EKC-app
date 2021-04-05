//
//  ProductsView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import SwiftUI

struct ProductsView: View {
    
    @EnvironmentObject var accountModel: AccountModel
    var model = ProductsModel()
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                
                VStack(spacing: 20) {
                    
                    ForEach(model.products) {product in
                        
                        VStack {
                            
                            HStack {
                                
                                Text(product.title)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.label)
                                
                                Spacer()
                                
                                Text(formatPrice(price: product.price))
                                    .foregroundColor(.label)
                            }
                            
                            Text(product.description)
                                .font(.subheadline)
                                .foregroundColor(.secondaryLabel)
                                .leading()
                                .padding(.vertical)
                            
                            if let account = accountModel.account {
                                if product.id == "membership" && account.isMember {
                                    
                                    ButtonView(text: "Next", destination: AnyView(Payment(product)), disabled: true)
                                } else {
                                    ButtonView(text: "Next", destination: AnyView(Payment(product)), disabled: false)
                                }
                            } else {
                                ButtonView(text: "Next", destination: AnyView(Payment(product)), disabled: false)
                            }
                            
                        }.carded()
                    }
                }.padding(.bottom)
                
            }.header(title: "Products")
        }
    }
}

extension ProductsView {
    
    func formatPrice(price: Int) -> String {
        let formattedPrice = (price / 100)
        
        return "$\(formattedPrice).00"
    }
}

struct Product: Identifiable {
    
    var id: String
    var title: String
    var description: String
    var price: Int
    
}
