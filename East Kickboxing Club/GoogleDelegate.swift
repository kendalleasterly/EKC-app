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
    
    //sign in with google auth
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        print("sign in function called")
        
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
        //once we have signed in with google auth, we can then sign in with firebase (two different things)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let err = error {
                print("error signing in google user with firebase", err)
            } else {
                print("successfully signed in with firebase")
                
                //you must create their doucment before continuing
                
                if let user = result?.user {
                    if let email = user.email, let name = user.displayName{

                        self.userDoesExist(uid: user.uid) { doesExist in
                            
                            if !doesExist {
                                
                                print("user did not exist")
                                
                                let stripeModel = StripeModel()
                                
                                stripeModel.addUser(name: name, email: email, uid: user.uid) { stripeCustomerID in
                                    
                                    self.createNewUser(name: name, email: email, uid: user.uid, stripeCustomerID: stripeCustomerID)
                                }
                            } else {
                                print("user did exist")
                            }
                        }

//                        self.navigationModel.state = .signedIn

                    } else {
                        print("either the user didn't have an email or they didn't have a name")
                    }
                } else {
                    print("there was an error retrienving the user from firebase authentication after signing in")
                }
            }
        }
    }
    
    private func userDoesExist(uid: String, resolve: @escaping (Bool) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { snapshot, error in
            
            if let err = error {
                print("error getting document in user does exist:", err.localizedDescription)
                return
            }
            
            if let document = snapshot, document.exists {
                resolve(true)
            } else {
                resolve(false)
            }
        }
    }
    
    private func createNewUser(name: String, email: String, uid: String, stripeCustomerID: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).setData([
            "name":name,
            "email": email,
            "freeClasses":0,
            "daysLeft":-1,
            "isMember":false,
            "stripeCustomerID": stripeCustomerID
        ])

        print("set the user's data")
        
    }
    
}
