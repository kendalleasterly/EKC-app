//
//  LandingView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/2/21.
//

import SwiftUI
import GoogleSignIn
import Alamofire
import SwiftyJSON

struct LandingView: View {
    
    var body: some View {
        
        Button(action: {
            GIDSignIn.sharedInstance().signIn()
        }, label: {
            Text("Sign In With Google")
        })
        .onAppear {
            
            AF.request("https://east-kickboxing-club.herokuapp.com/create-stripe-customer", method: .post, parameters: ["name": "fake name", "email": "fakeEmail"] ).responseJSON { response in
                
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success:
                    print(JSON(response.data as! Data))
                
                }
                
                
            }
            
        }
        
    }
}
