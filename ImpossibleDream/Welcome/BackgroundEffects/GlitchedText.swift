//
//  GlitchedText.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/17/24.
//

import SwiftUI

struct GlitchedText: View {
    @State private var showGlitched: Bool
    @State private var currentSeconds = 0.0
    @State private var textSize: CGSize = .zero
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    let hapticsEnabled: Bool
    let text: String
    let upperLimit: Double
    let stages: [Double: Double?]
    let isGlitched: ((Bool) -> Void)?
    
    /// Initializer for `GlitchedText`
    /// - Parameters:
    ///   - text: A `String` that will be displayed. Defaults to "Impossible"
    ///   - upperLimit: A `Double` that determines when the glitch animation resets. Defaults to 2.0.
    ///   - stages: A dictionary where key is the timestamp and the value is the duration of the haptics starting at the timestamp.
    ///   Keys must be multiples of 0.2. Nil means no haptics will occur.
    ///   - hapticsEnabled: A `Bool` indicating whether or not haptics will be played when glitching. Defaults to true
    ///   - isGlitched: A closure that is called when the state changes between showing glitched or not.
    init(
        hapticsEnabled: Bool = true,
        text: String = "Impossible",
        upperLimit: Double = 2.0,
        stages: [Double: Double?] = [
            0.0: 0.6,
            0.6: nil,
            1.8: 0.2
        ],
        isGlitched: ((Bool) -> Void)? = nil
    ) {
        self.hapticsEnabled = hapticsEnabled
        self.text = text
        self.upperLimit = upperLimit
        self.stages = stages
        _showGlitched = State(initialValue: stages[0.0, default: nil] != nil)
        self.isGlitched = isGlitched
    }
    
    var body: some View {
        Group {
            if showGlitched {
                glitchedText
            } else {
                Text(text)
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .preference(key: SizePreferenceKey.self, value: proxy.size)
                        }
                    )
                    .onPreferenceChange(SizePreferenceKey.self) { preference in
                        textSize = preference
                    }
            }
        }
        .onAppear(perform: CoreHapticsManager.shared.prepareHaptics)
        .onReceive(timer) { _ in
            currentSeconds = rounded(currentSeconds) == upperLimit ? 0 : currentSeconds + 0.2
            
            for (timestamp, duration) in stages {
                if rounded(currentSeconds) == timestamp {
                    if let duration {
                        showGlitched = true
                        if hapticsEnabled {
                            CoreHapticsManager.shared.glitchHaptic(duration: duration)
                        }
                    } else {
                        showGlitched = false
                    }
                }
            }
        }
        .onChange(of: showGlitched) { isGlitched?($1) }
    }
    
    private var glitchedText: some View {
        VStack(spacing: 0) {
            Text(text)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .frame(height: textSize.height / 2, alignment: .top)
                .clipped()
                .offset(x: 1, y: 1)
            
            Text(text)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .frame(height: textSize.height / 2, alignment: .bottom)
                .clipped()
                .offset(x: -3)
            
        }
    }
    
    private func rounded(_ n: Double) -> Double { round(n * 10) / 10.0 }
}

#Preview {
    GlitchedText()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .foregroundStyle(.white)
}
