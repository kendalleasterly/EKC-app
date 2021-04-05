//
//  AccountView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/13/21.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn

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
    
    @Environment (\.self.presentationMode) var presentationMode
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var model: AccountModel
    
    var body: some View {
        
        VStack {
            
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("x")
                    .leading()
            })
            
            Spacer()
            
            Image("logo")
                .frame(width: 75, height: 75)
            
            Spacer()
            
            VStack(alignment: .leading) {
                
                InfoBar(icon: "user", text: model.account.name)
                
                InfoBar(icon: "mail", text: model.account.email)
                
                InfoBar(icon: "calendar", text: model.nextBooking)
                
                InfoBar(icon: "crown", text: model.account.isMember ? "You are a member" : "You are not a member")
            }.leading()
            
            
            Spacer()
            
            ButtonView(text: "Sign Out") {
                
                let firebaseAuth = Auth.auth()
                
                do {
                  try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
                
                presentationMode.wrappedValue.dismiss()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    navigationModel.state = .signedOut
                }
                
                print("let the navigation model know what's up")
                
            }
            
        }.padding(.horizontal, 10)
        .padding(.vertical)
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
