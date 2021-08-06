//
//  BookView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI

struct BookView: View {
    
    @EnvironmentObject var model: BookingModel
    @EnvironmentObject var accountModel: AccountModel
    @State var selectedDay = Int(Calendar.current.component(.day, from: Date()))
    @State var isShowingAccount = false
    
    let collumns = [
        
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        NavigationView{
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: collumns, content: {
                    ForEach(0..<getDays().count) { day in
                        
                        let currentItem: String = getDays()[day]
                        
                        if currentItem == "S" ||
                            currentItem == "M" ||
                            currentItem == "W" ||
                            currentItem == "T" ||
                            currentItem == "F" {
                            
                            Text(currentItem)
                                .foregroundColor(.label)
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                        } else {
                            
                            DaySubView(availableClasses: Array(model.availableClasses.keys), selectedDay: $selectedDay, day: Int(currentItem)!)
                            
                        }
                    }
                }).carded(py: 28)
                .padding(.all)
                
                if model.availableClasses.keys.contains(selectedDay) {
                    
                    ForEach(model.availableClasses[selectedDay]!) {kickboxingClass in
                        
                        VStack {
                            
                            Text(getInfoDate(kickboxingClass.date))
                                .trailing()
                                .foregroundColor(.secondaryLabel)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                VStack (alignment: .leading, spacing: 5) {
                                    Text("Time")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondaryLabel)
                                    
                                    Text(kickboxingClass.date.getTime())
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                                VStack (alignment: .leading, spacing: 5){
                                    Text("Price")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondaryLabel)
                                    
                                    Text("$15.00")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                                VStack (alignment: .leading, spacing: 5){
                                    Text("Type")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondaryLabel)
                                    
                                    Text(getClassType(kickboxingClass: kickboxingClass))
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                                VStack (alignment: .leading, spacing: 5){
                                    Text("Attendees")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondaryLabel)
                                    
                                    Text(getAttendees(kickboxingClass: kickboxingClass))
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                                
                                
                            }.leading()
                            
                            ButtonView(text: "Next", destination: decideNextStep(), function: {
                                model.selectedClass = kickboxingClass
                            }).padding(.top)
                        }.carded()
                        .padding([.bottom, .horizontal])
                    }
                }
                
            }
            .header(title: "Book", horizontalPadding: false)
            
        }
    }
}

extension BookView {
    
    func getDays() -> [String] {
        
        let calendar = Calendar.current
        var components = DateComponents()
        
        
        components.year = calendar.component(.year, from: Date())
        components.month = calendar.component(.month, from: Date())
        
        let firstOfMonth = calendar.date(from: components)
        let offset = calendar.component(.weekday, from: firstOfMonth!)
        
        
        components.month = calendar.component(.month, from: Date()) + 1
        components.day = 0
        
        let lastOfMonth = calendar.date(from: components)
        let amountOfDays = calendar.component(.day, from: lastOfMonth!)
        
        var daysArray = [String]()
        
        for day in calendar.veryShortWeekdaySymbols {
            daysArray.append(day)
        }
        
        for _ in 1..<offset {
            daysArray.append(" ")
        }
        
        for i in 1...amountOfDays {
            daysArray.append(String(i))
        }
        
        return daysArray
        
    }
    
    func getInfoDate(_ date: Date) -> String {
        
        let monthInt = Calendar.current.component(.month, from: date)
        let month = Calendar.current.monthSymbols[monthInt - 1]
        
        return "\(month) \(selectedDay)"
    }
    
    func decideNextStep() -> AnyView {
        
        if accountModel.account.isMember || accountModel.account.freeClasses > 0 {
            return AnyView(ClassesAvailable())
        } else {
            return AnyView(Payment())
        }
    }
    
    func getClassType(kickboxingClass: Class) -> String {
        
        switch kickboxingClass.type {
        case "adult":
            return "For adults"
        case "kid":
            return "For kids"
        default:
            return "For adults"
        }
    }
    
    func getAttendees(kickboxingClass: Class) -> String {
        
        let attendees = kickboxingClass.attendees
        
        var attendeesString = ""
        
        if (attendees.count == 0) {
            attendeesString = "None yet, be the first!"
        } else if (attendees.count == 1) {
            attendeesString = attendees[0].name
        } else {
            
            attendees.forEach { attendee in
                
                if (attendees[0].id != attendee.id) {
                    
                    attendeesString = "\(attendeesString), \(attendee.name)"
                    
                } else {
                    attendeesString = attendee.name
                }
            }
        }
        
        return attendeesString
        
    }
}


struct DaySubView: View {
    
    let availableClasses: [Int]
    @Binding var selectedDay: Int
    let day: Int
    
    var body: some View {
        
        Button(action: {
            
            selectedDay = day
            
        }, label: {
            
            if selectedDay == day {
                
                
                ZStack {
                    Circle()
                        .foregroundColor(availableClasses.contains(day) ? .accent : .tertiaryLabel)
                    
                    Text(String(day))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondaryBackground)
                    
                    
                }.frame(width: 32, height: 32)
                .padding(.top)
                
                
                
            } else {
                Text(String(day))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(availableClasses.contains(day) ? .accent : .tertiaryLabel)
                    .frame(width: 32, height: 32)
                    .padding(.top)
            }
            
        }).disabled(!availableClasses.contains(day))
    }
}

