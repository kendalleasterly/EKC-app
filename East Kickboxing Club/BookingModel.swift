//
//  BookingModel.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import Foundation
import FirebaseFirestore

class BookingModel: ObservableObject {
    
    @Published var availableClasses =  [String: [Date]]()
    @Published var selectedDate = Date()
    
    let db = Firestore.firestore()
    
    func getClasses() {
        
        //get the first of this month
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.year = calendar.component(.year, from: Date())
        components.month = calendar.component(.month, from: Date())
        
        let firstOfMonth = calendar.date(from: components)
        
        guard firstOfMonth != nil else { fatalError("the first of the month was nil..?") }
        
        db.collection("classes")
            .whereField("date", isGreaterThanOrEqualTo: FirebaseFirestore.Timestamp(date: firstOfMonth!))
            .getDocuments { (snapshot, error) in
                
                if let err = error {
                    print("error in getting classes: " + err.localizedDescription)
                } else {
                    if let documents = snapshot?.documents {
                        
                        var availableClassesDict = [String: [Date]]()
                        
                        documents.forEach { document in
                            
                            let data = document.data()
                            let date = data["date"] as! Timestamp
                            let dateValue = date.dateValue()
                            let day = calendar.component(.day, from: dateValue)
                            
                            let attendees = data["attendees"] as! [String]
                            
                            if attendees.count < 8 {
                                
                                if availableClassesDict[String(day)] != nil {

                                    availableClassesDict[String(day)]!.append(dateValue)
                                } else {
                                    
                                    availableClassesDict[String(day)] = [dateValue]
                                    
                                }
                            }
                        }
                        
                        self.availableClasses = availableClassesDict
                    }
                }
            }
    }
    
    func bookClass()
    
}
