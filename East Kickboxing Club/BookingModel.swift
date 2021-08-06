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
    
    var allClasses =  [Class]()
    
    @Published var availableClasses = [Int: [Class]]()
    @Published var selectedClass: Class? = nil
    
    let db = Firestore.firestore()
    let accountModel: AccountModel
    
    init (accountModel: AccountModel) {
        self.accountModel = accountModel
    }
    
    func getClasses() {
        
        print("get classes was called")
        
        db.collection("classes")
            .whereField("date", isGreaterThanOrEqualTo: FirebaseFirestore.Timestamp(date: Date()))
            .getDocuments { (snapshot, error) in
                print("the completion was called")
                if let err = error {
                    print("error in getting classes: " + err.localizedDescription)
                    return
                }
                
                var allClassesArray = [Class]()
                
                snapshot!.documents.forEach { document in
                    
                    let data = document.data()
                    let rawDate = data["date"] as! Timestamp
                    let date = rawDate.dateValue()
                    let type = data["classType"] as! String
                    let rawAttendees = data["attendees"] as! [[String:String]]
                    var attendees = [Attendee]()
                    
                    rawAttendees.forEach { attendee in
                        
                        let id = attendee["id"]!
                        let name = attendee["name"]!
                        
                        let attendeeObject = Attendee(id: id, name: name)
                        
                        attendees.append(attendeeObject)
                    }
                    
                    let kickboxingClass = Class(id: document.documentID, type: type, attendees: attendees, date: date)
                    
                    if kickboxingClass.attendees.count < 8 {
                        allClassesArray.append(kickboxingClass)
                    }
                }
                
                self.allClasses = allClassesArray
                
                self.getClassesFor(selectedMonth: Calendar.current.component(.month, from: Date()))
                
            }
    }
    
    func getClassesFor(selectedMonth: Int) {
        
        let calendar = Calendar.current
        
        var availableClassesDict = [Int: [Class]]()
        
        allClasses.forEach { kickboxingClass in
            
            let date = kickboxingClass.date
            
            if calendar.component(.month, from: date) == selectedMonth {
                
                let day = calendar.component(.day, from: date)
                
                if availableClassesDict[day] == nil {
                    availableClassesDict[day] = [kickboxingClass]
                } else {
                    availableClassesDict[day]!.append(kickboxingClass)
                }
            }
        }
        
        self.availableClasses = availableClassesDict
        
    }
    
    func bookClass(willUseFreeClasses: Bool = false) {
        
        let account = accountModel.account
        
        if let selectedClass = selectedClass {
            
            let bookingsRef = db.collection("bookings")
            let accountRef = db.collection("users").document(account.id)
            let classRef = db.collection("classes").document(selectedClass.id)
            
            bookingsRef.addDocument(data: [
                "time": FirebaseFirestore.Timestamp(date: selectedClass.date),
                "userID":account.id
            ])
            
            if (willUseFreeClasses && !account.isMember) {
                accountRef.updateData([
                    "freeClasses": FirebaseFirestore.FieldValue.increment(Double(-1))
                ])
            }
            
            
            let simplifiedUserObject = [
                "name": account.name,
                "email": account.name,
                "id": account.id
            ]
            
            classRef.updateData([
                "attendees":FirebaseFirestore.FieldValue.arrayUnion([simplifiedUserObject])
            ])
        }
    }
}

struct Attendee: Identifiable {
    var id: String
    var name: String
}

struct Class: Identifiable {
    
    var id: String
    var type: String
    var attendees: [Attendee]
    var date: Date
    
}

//we'll keep the selected month variable in the view as a state variable.
//there will be a funciton defined here that will be called in the view that returns all of the days that match the selected month. the selected month will be passed in as a parameter.
