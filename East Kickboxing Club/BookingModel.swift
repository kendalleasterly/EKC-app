//
//  BookingModel.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class BookingModel: ObservableObject {
    
    @Published var availableClasses =  [String: [Date]]()
    
    @Published var selectedDate = Date()
    @Published var bookingWillUseFreeClasses = false
    
    
    let db = Firestore.firestore()
    
    func getClasses() {
        
        print("get classes was called")
        
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
                print("the completion was called")
                if let err = error {
                    print("error in getting classes: " + err.localizedDescription)
                } else {
                    if let documents = snapshot?.documents {
                        print("the documents existed")
                        var availableClassesDict = [String: [Date]]()
                        
                        documents.forEach { document in
                            print("i'm in a for each for", document.documentID)
                            let data = document.data()
                            let date = data["date"] as! Timestamp
                            let dateValue = date.dateValue()
                            let day = calendar.component(.day, from: dateValue)
                            
                            let attendees = data["attendees"] as! [String]
                            
                            if dateValue.timeIntervalSinceNow > 0 {
                                if attendees.count < 8 {
                                    
                                    if availableClassesDict[String(day)] != nil {
                                        
                                        availableClassesDict[String(day)]!.append(dateValue)
                                    } else {
                                        
                                        availableClassesDict[String(day)] = [dateValue]
                                        
                                    }
                                }
                            }
                            
                        }
                        
                        print("the final available classes are", availableClassesDict.description)
                        
                        self.availableClasses = availableClassesDict
                    }
                }
            }
    }
    
    func bookClass(isMember: Bool) {
        
        if let uid = Auth.auth().currentUser?.uid {
            
            let classQuerey = db.collection("classes").whereField("date", isEqualTo: FirebaseFirestore.Timestamp(date: selectedDate))
            let accountRef = db.collection("users").document(uid)
            
            //add a booking document
            db.collection("bookings").addDocument(data: [
                "time":FirebaseFirestore.Timestamp(date: selectedDate),
                "userID":uid
            ])
            
            //figure out which class it wants using the date
            
            classQuerey.getDocuments { (snapshot, error) in
                if let err = error {
                    print("there was an error getting the documents:", err.localizedDescription)
                    
                    return
                }
                
                let classRef =  snapshot!.documents[0].reference
                
                //append the current id to the class we get
                classRef.updateData(
                    ["attendees" : FieldValue.arrayUnion([uid])]
                )
            }
            
            //if we're not a member and we're using free classes subtract one free class from the account
            if !isMember && bookingWillUseFreeClasses {
                
                accountRef.updateData(["freeClasses" : FieldValue.increment(Double(-1))])
            }
        }
    }
}
