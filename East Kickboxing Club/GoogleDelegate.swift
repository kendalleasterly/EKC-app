//
//  GoogleDelegate.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/2/21.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

class GoogleDelegate: NSObject, GIDSignInDelegate, ObservableObject {
    
    let navigationModel: NavigationModel
    
    init(navigationModel: NavigationModel) {
        self.navigationModel = navigationModel
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("the user has not signed in before or they have since signed out")
            } else {
                print("error signing in use: \(err.localizedDescription)")
            }
            
            return
            
        }
        
        guard let authentication = user.authentication else {return}
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        //TODO: do something here that checks if they have an account already. If not, you need to add their document in database
        Auth.auth().signIn(with: credential) { (result, error) in
            if let err = error {
                print("error signing in google user with firebase", err)
            } else {
                print("we are signied in with firebase")
                
                //you must create their doucment before continuing
                
                let db = Firestore.firestore()
                
                
                if let user = result?.user {
                    
                    if user.email != nil && user.displayName != nil{
                        
                        db.collection("users").document(user.uid).setData([
                            "daysLeft":-1,
                            "email": user.email!,
                            "freeClasses":0,
                            "isMember":false,
                            "name":user.displayName!
                            
                        ])
                        
                        self.navigationModel.state = .signedIn
                        
                    } else {
                        print("either the user didn't have an email or they didn't have a name")
                    }
                } else {
                    print("there was an error retrienving the user from firebase after signing in")
                }
            }
        }
    }
}