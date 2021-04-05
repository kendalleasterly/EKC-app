//
//  AccountModel.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class AccountModel: ObservableObject {
    
    @Published var account = Account(isMember: false, name: "Loading...", freeClasses: 0, email: "")
    @Published var nextBooking = "You have no upcoming classes"
    
    let db = Firestore.firestore()
    
    func getData() {
        
        if let uid = Auth.auth().currentUser?.uid {
            
            db.collection("users").document(uid).addSnapshotListener { (snapshot, error) in
                
                if let err = error  {
                    
                    print("error in getting acccount data: " + err.localizedDescription)
                } else {
                    if let document = snapshot {
                        
                        if let data = document.data() {
                            
                            let acc = Account(isMember: data["isMember"] as! Bool,
                                              name: data["name"] as! String,
                                              freeClasses: data["freeClasses"] as! Int,
                                              email: data["email"] as! String)
                            
                            self.account = acc
                        }
                    } else {
                        print("error in getting account data, doc doesn't exist")
                    }
                }
            }
        }
    }
    
    func getNextBooking() {
        
        if let uid = Auth.auth().currentUser?.uid {
            
            db.collection("bookings")
                .whereField("userID", isEqualTo: uid)
                .whereField("time", isGreaterThanOrEqualTo: FirebaseFirestore.Timestamp(date: Date()))
                .order(by: "time", descending: false)
                .getDocuments { (snapshot, error) in
                    
                    if let err = error {
                        print("error getting next booking:", err.localizedDescription)
                        return
                    }
                    
                    if let snapshot = snapshot {
                        if !snapshot.isEmpty {
                            let data = snapshot.documents[0].data()
                            let calendar = Calendar.current
                            
                            let dateTimestamp = data["time"] as! Timestamp
                            let date = dateTimestamp.dateValue()
                            
                            let currentDay = calendar.component(.day, from: Date())
                            
                            let givenDay = calendar.component(.day, from: date)
                            
                            let time = date.getTime()
                            
                            let weekdayInt = calendar.component(.weekday, from: date)
                            let weekday = calendar.weekdaySymbols[weekdayInt - 1]
                            
                            
                            let difference = givenDay - currentDay
                            
                            
                            if difference == 0 {
                                //if it's 0, it's today
                                self.nextBooking = "Your next class is today at \(time)"
                            } else if difference == 1 {
                                //if it's 1, it's tomorrow
                                self.nextBooking = "Your next class is tomorrow at \(time)"
                            } else if difference < 7 {
                                
                                self.nextBooking = "Your next class is \(weekday) at \(time)"
                            } else {
                                
                                let month = calendar.monthSymbols[calendar.component(.month, from: date) - 1]
                                
                                self.nextBooking = "Your next class is \(weekday), \(month) \(givenDay) at \(time)"
                                
                            }
                        }
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
