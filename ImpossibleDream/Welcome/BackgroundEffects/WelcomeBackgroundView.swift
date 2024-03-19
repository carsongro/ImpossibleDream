//
//  WelcomeBackgroundView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/18/24.
//

import SwiftUI

struct WelcomeBackgroundView: View {
    let upperLimit = 23.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var currentSeconds = 0.0
    @State private var view: AnyView?
    
    let views: [Range<Double>: AnyView] = [
        0..<3.4: AnyView(RollinRainbowView()),
        3.4..<6: AnyView(RainbowGridView()),
        6..<8: AnyView(GlitchedTextEffect()),
        8..<11.5: AnyView(DancingDotsView()),
        11.5..<15.5: AnyView(EruptEffect()),
        15.5..<21.5: AnyView(RedactedGrid()),
        21.5..<23.0: AnyView(RedRectangles())
    ]
    
    var body: some View {
        Group {
            if 0..<3.4 ~= currentSeconds {
                RollinRainbowView()
            } else if 3.4..<6 ~= currentSeconds {
                RainbowGridView()
            } else if 6..<8 ~= currentSeconds {
                GlitchedTextEffect()
            } else if 8..<11.5 ~= currentSeconds {
                DancingDotsView()
            } else if 11.5..<15.5 ~= currentSeconds {
                EruptEffect()
            } else if 15.5..<21.5 ~= currentSeconds {
                RedactedGrid()
            } else if 21.5..<23.0 ~= currentSeconds {
                RedRectangles()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(timer) { _ in
            currentSeconds = rounded(currentSeconds) >= upperLimit ? 0 : currentSeconds + 0.1
            
//            for (range, view) in views {
//                if range ~= currentSeconds {
//                    self.view = view
//                    break
//                }
//            }
        }
    }
    
    private func rounded(_ n: Double) -> Double { round(n * 10) / 10.0 }
}

#Preview {
    WelcomeBackgroundView()
}
