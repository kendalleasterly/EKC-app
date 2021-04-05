//
//  Date+Extension.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/4/21.
//

import Foundation

extension Date {
    
    func getTime() -> String {
        
        var hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        
        
        if hour < 12 {
            if minute != 0 {
                return "\(hour):\(minute) AM"
            } else {
                return "\(hour) AM"
            }
        } else {
            
            hour -= 12
            
            if minute != 0 {
                return "\(hour):\(minute) PM"
            } else {
                return "\(hour) PM"
            }
        }
    }
}
