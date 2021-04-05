//
//  LandingView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/2/21.
//

import SwiftUI
import GoogleSignIn

struct LandingView: View {
    
    var body: some View {
        
        Button(action: {
            GIDSignIn.sharedInstance().signIn()
        }, label: {
            Text("Sign In With Google")
        })
        
    }
}
