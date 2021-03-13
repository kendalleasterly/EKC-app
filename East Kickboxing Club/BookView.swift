//
//  BookView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI

struct BookView: View {
    var body: some View {
        VStack{
            
            HStack {
            //header
                
                Button {
                    print("button Pressed")
                } label: {
                    Image("user")
                }.padding(.trailing, 10)
                
                Text("Book")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.label)

                Spacer()
            
            }
            
            Spacer()
            
        }.padding()
        .background(Color.background.edgesIgnoringSafeArea(.all))
        
        
    }
}
