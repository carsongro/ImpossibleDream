//
//  Glitch.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/17/24.
//

import SwiftUI

struct Glitch: View {
    @State private var showGlitched = true
    @State private var currentSeconds = 0.0
    
    private let stages = [
        (0 - 0.01)...(0 + 0.01),
        (0.6 - 0.01)...(0.6 + 0.01),
        (1.8 - 0.01)...(1.8 + 0.01),
        (2 - 0.01)...(2 + 0.01)
    ]
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    let text = "Impossible"
    
    var body: some View {
        Group {
            if showGlitched {
                glitchedText
            } else {
                Text(text)
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
        .onAppear(perform: CoreHapticsManager.shared.prepareHaptics)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .onReceive(timer) { _ in
            currentSeconds = stages[3] ~= currentSeconds ? 0 : currentSeconds + 0.2
            if stages[0] ~= currentSeconds {
                print("first \(currentSeconds)")
                showGlitched = true
                CoreHapticsManager.shared.glitchHaptic(duration: 0.6)
            } else if stages[1] ~= currentSeconds {
                print("second \(currentSeconds)")
                showGlitched = false
            } else if stages[2] ~= currentSeconds {
                print("third \(currentSeconds)")
                showGlitched = true
                CoreHapticsManager.shared.glitchHaptic(duration: 0.2)
            }
        }
    }
    
    private var glitchedText: some View {
        VStack(spacing: 0) {
            Text(text)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(height: 40, alignment: .top)
                .clipped()
            
            Text(text)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(height: 30, alignment: .bottom)
                .clipped()
                .offset(x: -3)
        }
    }
}

#Preview {
    Glitch()
}
