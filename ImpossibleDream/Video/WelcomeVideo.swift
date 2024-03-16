//
//  WelcomeVideo.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import SwiftUI

struct WelcomeVideo: UIViewControllerRepresentable {
    var isPlaying: Bool
    
    func makeUIViewController(context: Context) -> WelcomeVideoViewController {
        let vc = WelcomeVideoViewController()
        vc.isPlaying = isPlaying
        return vc
    }
    
    func updateUIViewController(_ uiViewController: WelcomeVideoViewController, context: Context) {
        uiViewController.isPlaying = isPlaying
    }
}
