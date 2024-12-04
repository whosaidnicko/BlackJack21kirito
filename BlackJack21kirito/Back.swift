//
//  Back.swift
//  BlackJack21kirito
//
//  Created by Nicolae Chivriga on 04/12/2024.
//

import SwiftUI


struct Back: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image("backB")
                .resizable()
                .frame(width: 30, height: 30)
        }

    
    }
}
