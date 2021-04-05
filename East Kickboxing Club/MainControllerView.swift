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
//            GIDSignIn.sharedInstance().restorePreviousSignIn()
            
            if Auth.auth().currentUser != nil {
                navigationModel.state = .signedIn
            }
        }
    }
}

