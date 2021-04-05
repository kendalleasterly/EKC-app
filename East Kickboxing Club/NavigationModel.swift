//
//  NavigationMode.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 4/2/21.
//

import SwiftUI
import FirebaseAuth

class NavigationModel: ObservableObject {
    
    @Published var state: viewState = .signedOut
    
}


enum viewState {
    case signedOut
    case signedIn
}
