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
    @State var selectedDay = String(Calendar.current.component(.day, from: Date()))
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
                            
                            DaySubView(availableClasses: Array(model.availableClasses.keys), selectedDay: $selectedDay, day: currentItem)
                            
                        }
                    }
                }).carded(py: 28).padding(.vertical)
                
                if model.availableClasses.keys.contains(selectedDay) {
                    
                    
                    ForEach(model.availableClasses[selectedDay]!, id:\.self) {date in
                        
                        VStack {
                            
                            Text(getInfoDate(date))
                                .trailing()
                                .foregroundColor(.secondaryLabel)
                            
                            VStack(alignment: .leading) {
                                
                                Group {
                                    Text("Time")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondaryLabel)
                                    
                                    
                                    Text(date.getTime())
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Price")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondaryLabel)
                                    
                                    Text("$15.00")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }.padding(.vertical, 10)
                                
                                Group {
                                    Text("Teacher")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondaryLabel)
                                    
                                    Text("Jason Easterly")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                            }.leading()
                            
                            ButtonView(text: "Next", destination: decideNextStep(), function: {
                                model.selectedDate = date
                            }).padding(.top)
                        }.carded()
                        .padding(.bottom)
                    }
                }
                
            }.header(title: "Book")
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
}


struct DaySubView: View {
    
    let availableClasses: [String]
    @Binding var selectedDay: String
    let day: String
    
    var body: some View {
        
        Button(action: {
            
            selectedDay = day
            
        }, label: {
            
            if selectedDay == day {
                
                
                ZStack {
                    Circle()
                        .foregroundColor(availableClasses.contains(day) ? .accent : .tertiaryLabel)
                    
                    Text(day)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondaryBackground)
                    
                    
                }.frame(width: 32, height: 32)
                .padding(.top)
                
                
                
            } else {
                Text(day)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(availableClasses.contains(day) ? .accent : .tertiaryLabel)
                    .frame(width: 32, height: 32)
                    .padding(.top)
            }
            
        }).disabled(!availableClasses.contains(day))
    }
}

