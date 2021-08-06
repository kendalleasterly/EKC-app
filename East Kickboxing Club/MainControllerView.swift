//
//  MainControllerView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/2/21.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct MainControllerView: View {
    
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        
        Group {
            
            if navigationModel.state == .signedIn {
                
                TabViewContainer().environmentObject(navigationModel)
            } else {
                
                LandingView()
            }
            
        }.onAppear {
            
            Auth.auth().addStateDidChangeListener { atuh, user in
                if user != nil {
                    navigationModel.state = .signedIn
                    print("we already had a current user")
                } else {
    //                GIDSignIn.sharedInstance().restorePreviousSignIn()
                    print("we didn't have a current user, showing landing view")
                }
            }
        }
    }
}

