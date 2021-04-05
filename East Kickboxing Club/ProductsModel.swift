//
//  ProductsModel.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/4/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProductsModel {
    
    let db = Firestore.firestore()
    let products = [
        Product(id: "threepack", title: "3 Pack", description: "Save $5!", price: 4000),
        Product(id: "fourpack", title: "4 Pack", description: "Save $10!", price: 5000),
        Product(id: "tenpack", title: "10 Pack", description: "Save $20!", price: 13000),
        Product(id: "membership", title: "Membership", description: "Unlimited classes for a month + one personal training session!", price: 18000),
    ]
    
    func addCreditsFrom(product: Product) {
        
        var creditAmount = 0
        
        switch product.id {
        case "threepack":
            creditAmount = 3
        case "fourpack":
            creditAmount = 4
        case "tenpack":
            creditAmount = 10
        default:
            print("the id given didn't work")
        }
        
        if let uid = Auth.auth().currentUser?.uid {
            
            db.collection("users").document(uid).updateData([
                "freeClasses":FieldValue.increment(Double(creditAmount))
            ])
        }
    }
    
    func makeMember() {
        if let uid = Auth.auth().currentUser?.uid {
            
            db.collection("users").document(uid).updateData([
                "isMember":true
            ])
        }
    }
}
