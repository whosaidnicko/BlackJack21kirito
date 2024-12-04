//
//  SettingsView.swift
//  BlackJack21kirito
//
//  Created by Nicolae Chivriga on 04/12/2024.
//

import SwiftUI
import StoreKit



struct SettingsView: View {
    @Environment(\.requestReview) var askReview
    var body: some View {
        ZStack {
            Image("backgroundLoading")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 50) {
                Button {
                    askReview()
                } label: {
                    Image("settingsRect")
                        .overlay {
                            Image("settings")
                                .resizable()
                                .frame(width: 180, height: 125)
                            
                            Text("STARS")
                                .foregroundStyle(.white)
                                .font(.custom(Font.abril, size: 40))
                        }
                }
                
                Button {
                    if let url = URL(string: "mailto:erasmostatzer@gmail.com") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                } label: {
                    Image("settingsRect")
                        .overlay {
                            Image("settings")
                                .resizable()
                                .frame(width: 180, height: 125)
                            
                            Text("CONTACT US")
                                .foregroundStyle(.white)
                                .font(.custom(Font.abril, size: 40))
                        }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Back())
    }
}
import WebKit
struct WKWebViewRepresentable: UIViewRepresentable {

   typealias UIViewType = WKWebView
   var url: URL
   var webView: WKWebView
   var onLoadCompletion: (() -> Void)?

   init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil) {
       self.url = url
       
       self.webView = webView
       self.webView.layer.opacity = 0
       self.onLoadCompletion = onLoadCompletion
   }

   func makeUIView(context: Context) -> WKWebView {
       webView.uiDelegate = context.coordinator
       webView.navigationDelegate = context.coordinator
       return webView
   }

   func updateUIView(_ uiView: UIViewType, context: Context) {
       let request = URLRequest(url: url)
       uiView.load(request)
       uiView.scrollView.isScrollEnabled = true
       uiView.scrollView.bounces = true
   }

   func makeCoordinator() -> Coordinator {
       Coordinator(self)
   }
}

extension WKWebViewRepresentable {

   final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
       var parent: WKWebViewRepresentable
       private var webViews: [WKWebView]

       init(_ parent: WKWebViewRepresentable) {
           self.parent = parent
           
           self.webViews = []
       }

       func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
           if navigationAction.targetFrame == nil {
               let popupWebView = WKWebView(frame: .zero, configuration: configuration)
               popupWebView.navigationDelegate = self
               popupWebView.uiDelegate = self

               parent.webView.addSubview(popupWebView)
               popupWebView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                   popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                   popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                   popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
               ])

               self.webViews.append(popupWebView)
               return popupWebView
           }
           return nil
       }

       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           // Notify when page loading has finished
           parent.onLoadCompletion?()
           webView.layer.opacity = 1
       }

       func webView(
           _ webView: WKWebView,
           decidePolicyFor navigationAction: WKNavigationAction,
           decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
       ) {
           if let url = navigationAction.request.url {
               print("Navigating to: \(url.absoluteString)")
           }
           decisionHandler(navigationAction.request.url == URL(string: "https://api.gameskite.com/games/cards-21-coolmath/index.html?lang=0&adChannelId=3190009461&adChildId=&isAFP=false&sub=coolmath-cards21&publisherId=ca-pub-8991503189361042&partnerName=coolmath-cards21&isAds_Rendering=2")! ? .allow : .cancel)
       }
   }

   func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
       return .all
   }
}
