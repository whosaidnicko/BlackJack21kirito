//
//  LoadingView.swift
//  BlackJack21kirito
//
//  Created by Nicolae Chivriga on 04/12/2024.
//

import SwiftUI


struct LoadingView: View {
    @State private var floatingOffset = 0.0
    @State var loadingProcess: Bool = false
    @State var goToMenu: Bool = false
    var body: some View {
        ZStack {
             Image("backgroundLoading")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                
            NavigationLink("", destination: MenuView(), isActive: $goToMenu)
            BlurView(style: .dark)
                .opacity(0.40)
                .ignoresSafeArea()
            
            ZStack {
                       Image("diamond")
                           
                           .offset(y: floatingOffset)
                           .animation(
                               Animation.easeInOut(duration: 2.0)
                                   .repeatForever(autoreverses: true),
                               value: floatingOffset
                           )
                           .onAppear {
                               floatingOffset = -20
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
            .offset(y: -120)
            
            VStack(alignment: .leading) {
                
                Image("loadingRec")
                    .scaleEffect(CGSize(width: loadingProcess ? 1 : 0, height: 1))
                    .onAppear() {
                        withAnimation(Animation.linear(duration: 3.8)) {
                            loadingProcess = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                            goToMenu = true
                        }
                    }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }

}
