//
//  AccountModel.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI
import FirebaseFirestore

class AccountModel: ObservableObject {
    
    @Published var account: Account?
    let db = Firestore.firestore()
    
    func getData() {
        
        db.collection("users").document("z39Uj79XnkRzw7LHnLotg6shSbp1").addSnapshotListener { (snapshot, error) in
            
            if let err = error  {

                print("error in getting acccount data: " + err.localizedDescription)
            } else {
                if let document = snapshot {
                    
                    let data = document.data()!
                    print(data)
                    
                    let acc = Account(isMember: data["isMember"] as! Bool,
                                      name: data["name"] as! String,
                                      freeClasses: data["freeClasses"] as! Int,
                                      email: data["email"] as! String)
                    
                    self.account = acc


                } else {
                    print("error in getting account data, doc doesn't exist")
                }
            }
        }
    }
}

struct Account {

    var isMember: Bool
    var name: String
    var freeClasses: Int
    var email: String
    
}
