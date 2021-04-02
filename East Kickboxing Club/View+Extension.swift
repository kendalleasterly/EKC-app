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
    
    func carded() -> some View {
        return self.modifier(CardedModifier())
    }
    
    func carded(py: CGFloat) -> some View {
        return self.modifier(CardedModifier(px: py))
    }
    
    
    func customNavBar(proxy: GeometryProxy,
                      title: String,
                      _ leading: Button<AnyView>,
                      _ trailing: Button<AnyView>) -> some View {
        
        return self.modifier(CustomNavBar(title: title, leading: leading, trailing: trailing, proxy: proxy))
        
    }
    
    func customNavBar(proxy: GeometryProxy,
                      title: String,
                      leading: Button<AnyView>) -> some View {
        
        return self.modifier(CustomNavBar(title: title, leading: leading, trailing: nil, proxy: proxy))
        
    }
    
    func customNavBar(proxy: GeometryProxy,
                      title: String,
                      trailing: Button<AnyView>) -> some View {
        
        return self.modifier(CustomNavBar(title: title, leading: nil, trailing: trailing, proxy: proxy))
        
    }
    
    func customNavBar(proxy: GeometryProxy,
                      title: String) -> some View {
        
        return self.modifier(CustomNavBar(title: title, leading: nil, trailing: nil, proxy: proxy))
        
    }
    
    func customNavBar(proxy: GeometryProxy,
                      title: String,
                      dissmissView: @escaping () -> Void) -> some View {
        
        return self.modifier(CustomNavBar(title: title,
                                          leading: Button( action: {
                                            dissmissView()
                                          }, label: {
                                            AnyView(Image("back"))
                                          }), trailing: nil, proxy: proxy))
        
    }
    
    func header(title: String) -> some View{
        return self.modifier(HeaderModifier(title: title))
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
    
    var px: CGFloat = 32
    
    func body(content: Content) -> some View {
        
        content
            .padding(.horizontal, px)
            .padding(.vertical, 24)
            .background(Color.secondaryBackground)
            .cornerRadius(16.0)
        //            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.20000000298023224)), radius:40, x:0, y:20)
        
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
            
            content
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .padding(.top, 10)
                .padding(.horizontal)
        }.sheet(isPresented: $isShowingAccount, content: {AccountView()})
        .padding(.top)
        .background(Color.background.edgesIgnoringSafeArea(.all))
        
    }
    
}
