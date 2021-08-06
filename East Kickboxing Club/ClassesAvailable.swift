//
//  ClassesAvailable.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/1/21.
//

import SwiftUI

struct ClassesAvailable: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bookingModel: BookingModel
    @EnvironmentObject var accountModel: AccountModel
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack {
                
                Spacer()
                
                VStack {
                    Text(decideFreeClassesAmount().title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.label)
                        .multilineTextAlignment(.center)
                    
                    Text(decideFreeClassesAmount().description)
                        .foregroundColor(.label)
                        .padding(.vertical)
                    
                    HStack {
                        
                        NavigationLink(
                            destination: Payment(),
                            label: {
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("No")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundColor(.label)
                                    
                                    Spacer()
                                    
                                }.padding(.vertical, 5)
                                .background(RoundedRectangle(cornerRadius: 16.0)
                                                .strokeBorder(lineWidth: 2)
                                                .foregroundColor(.label))
                            }).padding(.trailing)
                        
                        ButtonView(text: "Yes", destination: AnyView(DoneView())) {
                            
                            if accountModel.account.isMember || accountModel.account.freeClasses > 0 {
                                bookingModel.bookClass(willUseFreeClasses: true)
                            } else {
                                print("didn't add class because user lacked sufficient resources")
                            }
                            
                        }
                    }.padding(.horizontal)
                }.carded(py: 24)
                
                Spacer()
                
                Spacer()
                
            }.padding()
            .customNavBar(proxy: proxy, title: "Use an Available Credit") {
                presentationMode.wrappedValue.dismiss()
            }
            
        }
    }
}

extension ClassesAvailable {
    
    func decideFreeClassesAmount() -> (title: String, description: String) {
        
        if accountModel.account.isMember {
            return ("You have an unlimted amount of free classes.", "Would you like to use one?")
        } else if accountModel.account.freeClasses == 1 {
            return ("You have 1 free class left.", "Would you like to use it?")
        } else {
            return ("You have \(accountModel.account.freeClasses) free classes left.", "Would you like to use one?")
        }
    }
}
