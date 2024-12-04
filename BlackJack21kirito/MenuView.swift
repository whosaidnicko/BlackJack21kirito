//
//  MenuView.swift
//  BlackJack21kirito
//
//  Created by Nicolae Chivriga on 04/12/2024.
//

import SwiftUI


struct MenuView: View {
    var body: some View {
        ZStack {
            Image("backgroundLoading")
               .resizable()
               .ignoresSafeArea()
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                
                NavigationLink {
                    PlayView()
                } label: {
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            HStack {
                                Text("PLAY")
                                    .font(.custom(Font.abril, size: 48))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                            .padding(.leading, 30)
                        }
                }
                
                NavigationLink {
                    RulesView()
                } label: {
                    Image("rules")
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            Text("RULES")
                                .font(.custom(Font.abril, size: 48))
                                .foregroundStyle(.white)
                        }
                }
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Image("settings")
                        .resizable()
                        .scaledToFit()
                    
                        .overlay {
                            Text("SETTINGS")
                                .font(.custom(Font.abril, size: 48))
                                .foregroundStyle(.white)
                        }
                }
                
                Spacer()
            }
            
            .padding(.bottom, 90)
        }
        .navigationBarBackButtonHidden()
    }
}


extension Font {
    static var abril: String = "AbrilFatface-Regular"
}
