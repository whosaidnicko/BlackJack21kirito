//
//  PlayView.swift
//  BlackJack21kirito
//
//  Created by Nicolae Chivriga on 04/12/2024.
//

import SwiftUI


struct PlayView: View {
    @State private var floatingOffset = 0.0
    @State var showGame: Bool  = false
    var body: some View {
        ZStack {
            Image("backgroundLoading")
               .resizable()
               .ignoresSafeArea()
            
            BlurView(style: .dark)
                .opacity(0.40)
                .ignoresSafeArea()
            ZStack {
                       Image("diamond")
                           
                    .rotationEffect(.degrees(floatingOffset != 0 ? 360 : 0))
                           .offset(y: floatingOffset)
                           .animation(
                               Animation.easeInOut(duration: 2.0)
                                   .repeatForever(autoreverses: true),
                               value: floatingOffset
                           )
                           .onAppear {
                               floatingOffset = -30
                           }

                       Image("card")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 80, height: 80)
                           .offset(x: floatingOffset * 2, y: -floatingOffset)
                           .animation(
                               Animation.easeInOut(duration: 3.0)
                                   .repeatForever(autoreverses: true),
                               value: floatingOffset
                           )
                   }
            
            WKWebViewRepresentable(url: URL(string: "https://freegames.org/games/blackjack/v1/")!, onLoadCompletion: {
                
                withAnimation(Animation.bouncy) {
                    showGame = true
                }
            })
            .offset(x: showGame ? 0 : -UIScreen.main.bounds.width)
            .cornerRadius(25)
            .frame(height: UIScreen.main.bounds.height * 0.85)
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Back())

    }
}
