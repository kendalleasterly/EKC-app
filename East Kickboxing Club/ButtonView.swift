//
//  ButtonView.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/20/21.
//

import SwiftUI

struct ButtonView: View {
    
    @State var linkIsActive: Bool = false
    var text: String
    var function: () -> Void
    var destination: AnyView?
    var disabled: Bool
    
    
    init(text: String, function: @escaping () -> Void, disabled: Bool) {

        self.text = text
        self.destination = nil
        self.function = function
        self.disabled = disabled

    }
    
    init(text: String, destination: AnyView, disabled: Bool, function: @escaping () -> Void) {
        self.text = text
        self.destination = destination
        self.function = function
        self.disabled = disabled
    }
    
    init(text: String, destination: AnyView, disabled: Bool) {
        self.text = text
        self.destination = destination
        self.function = {}
        self.disabled = disabled
    }
    
    init(text: String, function: @escaping () -> Void) {

        self.text = text
        self.destination = nil
        self.function = function
        self.disabled = false

    }
    
    init(text: String, destination: AnyView, function: @escaping () -> Void) {
        self.text = text
        self.destination = destination
        self.function = function
        self.disabled = false
    }
    
    var body: some View {
            
            Button(action: {
                
                if destination != nil {
                    linkIsActive = true
                }
                
                function()
                
                
            }, label: {
                
                HStack {
                    
                    Spacer()
                    
                    Text(text)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .foregroundColor(.gray50)
                    
                    Spacer()
                    
                }.padding(.vertical, 5)
                .background(RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(.accent)
                )
            }).background(NavigationLink(destination: destination != nil ? destination : AnyView(EmptyView()),
                                         isActive: $linkIsActive, label: {  EmptyView() }))
    }
}
