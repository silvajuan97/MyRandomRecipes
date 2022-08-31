//
//  VideoView.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 29/08/2022.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    let videoUrl: String
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: videoUrl) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}
