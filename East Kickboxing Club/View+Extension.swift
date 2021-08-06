//
//  View+Extension.swift
//  East Kickboxing Club
//
//  Created by Kendall Easterly on 3/12/21.
//

import SwiftUI

extension View {
    
    func centered() -> some View {
        return self.modifier(CenteredModifier())
    }
    
    func leading() -> some View {
        return self.modifier(LeadingModifier())
    }
    
    func trailing() -> some View {
        return self.modifier(TrailingModifier())
    }
    
    func carded(py: CGFloat = 32) -> some View {
        return self.modifier(CardedModifier(px: py))
    }
    
    
    func customNavBar(proxy: GeometryProxy,
                      title: String,
                      leading: Button<AnyView>? = nil,
                      trailing: Button<AnyView>? = nil) -> some View {
        
        return self.modifier(CustomNavBar(title: title, leading: leading, trailing: trailing, proxy: proxy))
        
    }

    
    func customNavBar(proxy: GeometryProxy,
                      title: String,
                      dissmissViewFunction: @escaping () -> Void) -> some View {
        
        return self.modifier(CustomNavBar(title: title,
                                          leading: Button( action: {
                                            dissmissViewFunction()
                                          }, label: {
                                            AnyView(Image("back"))
                                          }), trailing: nil, proxy: proxy))
        
    }
    
    func header(title: String, horizontalPadding: Bool = true) -> some View{
        return self.modifier(HeaderModifier(title: title, horizontalPadding: horizontalPadding))
    }
    
}

struct CenteredModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

struct LeadingModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        HStack {
            content
            Spacer()
        }
    }
}

struct TrailingModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        HStack {
            Spacer()
            content
        }
    }
}

struct CardedModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    var px: CGFloat
    
    func body(content: Content) -> some View {
        
        content
            .padding(.horizontal, px)
            .padding(.vertical, 24)
            .background(Color.secondaryBackground)
            .cornerRadius(16.0)
            .shadow(color: Color(.displayP3, red: 0, green: 0, blue: 0, opacity: 0.1), radius: 15, x: 0, y: 10)
            .shadow(color: Color(.displayP3, red: 0, green: 0, blue: 0, opacity: 0.05), radius: 6, x: 0, y: 4)
        
        
    }
}

struct CustomNavBar: ViewModifier {
    
    var title: String
    var leading: Button<AnyView>?
    var trailing: Button<AnyView>?
    var proxy: GeometryProxy
    
    func body(content: Content) -> some View {
        
        ZStack(alignment: .top) {
            
            if proxy.safeAreaInsets.top > 30 {
                
                content
                    .padding(.top, proxy.safeAreaInsets.top)
                    .padding(.top)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .background(Color.background.edgesIgnoringSafeArea(.all))
                
            } else {
                content
                    .padding(.top, proxy.safeAreaInsets.top)
                    .padding(.top)
                    .padding(.top)
                    .background(Color.background.edgesIgnoringSafeArea(.all))
            }
            
            //on x models, just do one top padding
            
            VStack {
                VStack {
                    
                    if proxy.safeAreaInsets.top > 30 {
                        HStack {
                            
                            if let leadingItem = leading {
                                
                                leadingItem
                                
                            }
                            
                            Spacer()
                            
                            if let trailingItem = trailing {
                                
                                trailingItem
                                
                            }
                        }.overlay(Text(title)
                                    .font(.title2)
                                    .fontWeight(.bold))
                        
                        .padding()
                    } else {
                        HStack {
                            
                            if let leadingItem = leading {
                                
                                leadingItem
                                
                            }
                            
                            Spacer()
                            
                            if let trailingItem = trailing {
                                
                                trailingItem
                                
                            }
                        }.overlay(Text(title)
                                    .font(.title2)
                                    .fontWeight(.bold))
                        
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    
                    
                    //on x models, just do one padding with default
                    
                    Divider()
                    
                }
                .padding(.top, proxy.safeAreaInsets.top)
                .background(Rectangle().foregroundColor(Color(UIColor.systemBackground)))
                .edgesIgnoringSafeArea(.top)
                
                Spacer()
                
            }
        }
    }
}

struct HeaderModifier: ViewModifier {
    
    @State var isShowingAccount = false
    var title: String
    var horizontalPadding: Bool
    
    func body(content: Content) -> some View {
        
        VStack (spacing: 0) {
            
            HStack {
                //header
                
                Button {
                    isShowingAccount.toggle()
                } label: {
                    Image("user")
                }.padding(.trailing, 10)
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.label)
                
                Spacer()
                
            }.padding(.bottom, 5)
            .padding(.horizontal)
            
            if horizontalPadding {
                content
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .padding(.top, 10)
                    .padding(.horizontal)
            } else {
                content
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .padding(.top, 10)
            }
            
            
        }.sheet(isPresented: $isShowingAccount, content: {AccountView()})
        .padding(.top)
        .background(Color.background.edgesIgnoringSafeArea(.all))
        
    }
    
}
