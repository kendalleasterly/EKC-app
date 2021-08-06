//
//  StripeModel.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 7/27/21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct StripeModel {
    
    func addUser(name: String, email: String, uid: String, resolve: @escaping (String) -> Void) {
        
        let serverURL = "https://east-kickboxing-club.herokuapp.com"
        
        let requestParameters = [
            "name":name,
            "email":email,
            "uid":uid
        ]
        
        AF.request(serverURL + "/create-stripe-customer", method: .post, parameters: requestParameters, encoder: JSONParameterEncoder.default).responseJSON { response in
            
            guard let data = response.data else {fatalError("couldn't create stripe user")}
            
            let json = try! JSON(data: data)
    
            print(json)
            
            resolve(json["id"].string!)
            
        }
        
    }
    
}
