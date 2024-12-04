//
//  RulesView.swift
//  BlackJack21kirito
//
//  Created by Nicolae Chivriga on 04/12/2024.
//

import SwiftUI

struct RulesView: View {
    
    var body: some View {
        ZStack {
            Image("backgroundLoading")
               .resizable()
               .scaledToFill()
               .ignoresSafeArea()
            
            Image("rulesRectang")
                .overlay {
                    Text("The goal is to beat the dealer by getting a hand closer to 21 without exceeding it. Number cards are worth their face value, face cards are worth 10, and Aces can be 1 or 11. Each player is dealt two cards, and they can 'hit' (draw more cards) or 'stand' (keep their hand). The dealer must draw until they have at least 17. If your hand exceeds 21, you 'bust' and lose. A Blackjack (Ace + 10-point card) wins automatically unless the dealer also has one.")
                        .font(.custom(Font.abril, size: 18))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 40)
                        .padding(.top, 120)
                        .multilineTextAlignment(.center)
                }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Back())
    }
}
