//
//  BookView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI

struct BookView: View {
    
    @EnvironmentObject var model: BookingModel
    @State var selectedDay = "7"
    @State var isShowingAccount = false
    
    var body: some View {
        VStack (spacing: 0){
            
            HStack {
                //header
                
                Button {
                    isShowingAccount.toggle()
                } label: {
                    Image("user")
                }.padding(.trailing, 10)
                
                Text("Book")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.label)
                
                Spacer()
                
            }.padding(.bottom, 5)
            .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                
                Spacer()
                
                HStack {
                    ForEach(0..<7) { day in
                        
                        VStack{
                            
                            Text(Calendar.current.veryShortWeekdaySymbols[day])
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            ForEach(0..<getDays().count) { row in
                                
                                DaySubView(availableClasses: Array(model.availableClasses.keys),
                                           selectedDay: $selectedDay,
                                           day: getDays()[row][day])
                                
                            }
                        }
                        
                        if day != 6 {
                            Spacer()
                        }
                        
                    }
                }.carded()
                .padding(.vertical)
                
                Spacer()
                
                if model.availableClasses.keys.contains(selectedDay) {
                    
                    VStack {
                        
                        Text(getInfoDate())
                            .trailing()
                            .foregroundColor(.secondaryLabel)
                        
                        VStack(alignment: .leading) {
                            
                            Group {
                                Text("Time")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondaryLabel)
                                
                                
                                Text(getInfoTime())
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
                            }.padding(.vertical)
                            
                            Group {
                                Text("Teacher")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondaryLabel)
                                
                                Text("Jason Easterly")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            
                        }
                        .leading()
                        
                    }.carded()
                }
                
                Spacer()
            }.padding(.horizontal)
            
        }.sheet(isPresented: $isShowingAccount, content: {AccountView()})
        .padding(.top)
        .background(Color.background.edgesIgnoringSafeArea(.all))
        
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

extension BookView {
    
    func getDays() -> [[String]] {
        
        //get all the days in one array
        
        var plainDaysArray = [String]()
        
        
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        var components = DateComponents()
        components.year = currentYear
        components.month = currentMonth + 1
        
        let nextMonth = Calendar.current.date(from: components)
        let lastDay = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth!)
        
        let numOfDays = Calendar.current.component(.day, from: lastDay!)
        
        for i in 1...numOfDays {
            plainDaysArray.append(String(i))
        }
        
        //add however many empty strings to the array that you need to offset
        
        components.month = currentMonth
        
        let thisMonth = Calendar.current.date(from: components)
        
        let offset = Calendar.current.component(.weekday, from: thisMonth!) - 1
        
        for _ in 0..<offset {
            plainDaysArray.insert(" ", at: 0)
        }
        
        //split every 7 and put those subarrays into one array
        
        var daysArray = [[String]]()
        
        //loop through each row, that will be the total days divided by 7. ROund it up.
        var rows: Double = Double(numOfDays) / 7
        rows.round(.up)
        
        for level in 0..<Int(rows) {
            var rowArray = [String]()
            
            var count = 0
            
            while count < 7 {
                
                let index = (level * 7) + count
                
                if index < plainDaysArray.count {
                    rowArray.append(plainDaysArray[index])
                } else {
                    rowArray.append(" ")
                }
                
                count += 1
                
            }
            
            daysArray.append(rowArray)
        }
        
        return daysArray
        
    }
    
    func getInfoDate() -> String {
        
        if let date = model.availableClasses[selectedDay] {
            
            let monthInt = Calendar.current.component(.month, from: date)
            let month = Calendar.current.monthSymbols[monthInt - 1]
            
            return "\(month) \(selectedDay)"
            
        } else {
            return ""
        }
    }
    
    func getInfoTime() -> String {
        
        if let date = model.availableClasses[selectedDay] {
            
            let hour = Calendar.current.component(.hour, from: date)
            let minute = Calendar.current.component(.minute, from: date)
            
            if minute == 0 {
                return "\(hour) AM"
            } else {
                return "\(hour):\(minute) AM"
            }
            
        } else {
            return ""
        }
        
    }
    
}
