//
//  AccountView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("logo")
            
            Spacer()
            
            VStack {
                InfoBar(icon: "user", text: "Kendall Easterly")
                
                InfoBar(icon: "mail", text: "qfletcher89@gmail.com")
                
                InfoBar(icon: "calendar", text: "Your next class is Thursday")
                
                InfoBar(icon: "crown", text: "You are a member")
            }
            
            
            Spacer()
            
            Button {
                print("sign out")
            } label: {
                Text("Sign Out")
                    .padding(.horizontal, 20)
                    .background(RoundedRectangle(cornerRadius: 16))
            }
            
            Spacer()

            
        }
        
    }
}

struct InfoBar: View {
    
    var icon: String
    var text: String
    
    var body: some View {
        
        HStack {
            Image(icon)
            
            Text(text)
        }
    }
}
