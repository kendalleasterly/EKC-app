//
//  ProductsView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import SwiftUI

struct ProductsView: View {
    
    @EnvironmentObject var accountModel: AccountModel
    let products = [
        Product(id: "threepack", title: "3 Pack", description: "Save $5!", price: 4000),
        Product(id: "fourpack", title: "4 Pack", description: "Save $10!", price: 5000),
        Product(id: "tenpack", title: "10 Pack", description: "Save $20!", price: 13000),
        Product(id: "membership", title: "Membership", description: "Unlimited classes for a month + one personal training session!", price: 18000),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    ForEach(products) {product in
                        
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
                                    
                                    ButtonView(text: "Next", destination: AnyView(Payment()), disabled: true)
                                } else {
                                    ButtonView(text: "Next", destination: AnyView(Payment()), disabled: false)
                                }
                            } else {
                                ButtonView(text: "Next", destination: AnyView(Payment()), disabled: false)
                            }
                            
                        }.carded()
                    }
                }
                
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
