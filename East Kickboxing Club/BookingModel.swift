//
//  BookingModel.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import Foundation
import FirebaseFirestore

class BookingModel: ObservableObject {
    
    @Published var availableClasses =  [String: Date]()
    
    let db = Firestore.firestore()
    
    func getClasses() {
        
        db.collection("test-classes").getDocuments { (snapshot, error) in
            
            if let err = error {
                print("error in getting classes: " + err.localizedDescription)
            } else {
                if let documents = snapshot?.documents {
                    
                    var availableClassesDict = [String: Date]()
                    
                    documents.forEach { document in
                        
                        let data = document.data()
                        let date = data["date"] as! Timestamp
                        let day = Calendar.current.component(.day, from: date.dateValue())
                        
                        let attendees = data["attendees"] as! [String]
                        
                        if attendees.count < 8 {
                            
                            availableClassesDict[String(day)] = date.dateValue()
                            
                        }
                    }
                    
                    print(availableClassesDict)
                    self.availableClasses = availableClassesDict
                    
                }
            }
        }
    }
}
