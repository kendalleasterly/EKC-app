//
//  ContentView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI
import GoogleSignIn

struct TabViewContainer: View {

    let accountModel: AccountModel
    let bookingModel: BookingModel
    
    init() {
        let accountModel = AccountModel()
        let bookingModel = BookingModel(accountModel: accountModel)
        
        self.accountModel = accountModel
        self.bookingModel = bookingModel
    }
    
    var body: some View {
        
        TabView {
            
            AdditionalDivider(content: BookView()
                                .environmentObject(bookingModel)
                                .environmentObject(accountModel))
            .tabItem {
                Image(systemName: "calendar")
            }
            
            AdditionalDivider(content: ProductsView().environmentObject(accountModel))
                .tabItem { Image(systemName: "cart") }
            
        }.onAppear {
            bookingModel.getClasses()
            accountModel.getData()
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
