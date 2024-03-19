//
//  Extensions.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI

extension View {
    func notvisionOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if !os(visionOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func gradientBackground() -> some View {
        var gradient: some View {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: (130.0 / 255.0), green: (109.0 / 255.0), blue: (204.0 / 255.0)),
                    Color(red: (130.0 / 255.0), green: (130.0 / 255.0), blue: (211.0 / 255.0)),
                    Color(red: (131.0 / 255.0), green: (160.0 / 255.0), blue: (218.0 / 255.0))
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .flipsForRightToLeftLayoutDirection(false)
            .ignoresSafeArea()
        }
        
        return self.background(gradient)
    }
}

extension Animation {
    static let openImage = Animation.spring(response: 0.45, dampingFraction: 0.9)
    static let closeImage = Animation.spring(response: 0.35, dampingFraction: 1)
    
    static var smooth: Animation {
        Animation.timingCurve(0.11, 0.16, 0.05, 1.53)
    }
    
    static func smooth(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0.11, 0.16, 0.00, 1.56, duration: duration)
    }
}
