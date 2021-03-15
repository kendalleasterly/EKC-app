//
//  AccountView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import SwiftUI

/*
use this: https://blckbirds.com/post/side-menu-hamburger-menu-in-swiftui/
 
 READ IT ALL BEFORE DOING ANYTHING
 
that link will give you all the information you need. You can also animate it something like reddit
 if you'd like, or just do it regularly. You don't have to shift the main content, actually I would prefer if you didn't. i want the menu to just do what it's doing without shifting the content. And this
 behavior should preferably be wrapped in a view modifer. When I say that I mean EVERYTHING, including
 the top bar, the button that activates it, all of it. The way this will work will be the modifier
 asking for a title. It will dispaly the tilte just like how it already does. if you want to get
 a nice slidy gesture instead of one that recongnizes a slide and then just closes, what you can do
 is track the gesture everytime it updates or gets called, and then track the data to some sort of offset
 point that the menu is on. this last feature won't be something I'll spend too much time on though,
 i'll only implement it if it seems like it won't take too long or the current way is REALLY bad.
 
 
*/

struct AccountView: View {
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("logo")
                .frame(width: 75, height: 75)
            
            Spacer()
            
            VStack(alignment: .leading) {
                InfoBar(icon: "user", text: "Kendall Easterly")
                
                InfoBar(icon: "mail", text: "qfletcher89@gmail.com")
                
                InfoBar(icon: "calendar", text: "Your next class is Thursday")
                
                InfoBar(icon: "crown", text: "You are a member")
            }.leading()
            
            
            Spacer()
            
            Button {
                print("sign out")
            } label: {
                Text("Sign Out")
                    .fontWeight(.medium)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 5)
                    .foregroundColor(.secondaryBackground)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.accent))
                    
            }.padding(.bottom)
            
            

            
        }.padding()
        
    }
}

struct InfoBar: View {
    
    var icon: String
    var text: String
    
    var body: some View {
        
        HStack() {
            Image(icon)
                .padding(.horizontal)
            
            Text(text)
                .fontWeight(.medium)
        }
    }
}
