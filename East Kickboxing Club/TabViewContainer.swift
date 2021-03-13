//
//  ContentView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI

struct TabViewContainer: View {
    
    @ObservedObject var accountModel = AccountModel()
    
    var body: some View {
        
        TabView{
            
            AdditionalDivider(content: BookView())
                .tabItem {
                    Image(systemName: "calendar")
                }
            
            AdditionalDivider(content: BookView())
                .tabItem { Image(systemName: "cart") }
            
        }.onAppear {
            
//            accountModel.getData()
            
        }
    }
}

struct AdditionalDivider<Content: View>: View {
    
    var content: Content
    
    @ViewBuilder var body: some View {
        
        ZStack(alignment: .bottom) {
            
            content
            
            Divider()
            
        }
        
    }
    
}
