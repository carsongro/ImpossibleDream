//
//  GlitchedText.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/17/24.
//

import SwiftUI

struct GlitchedText: View {
    var showGlitched: Bool
    
    @State private var textSize: CGSize = .zero
    
    var body: some View {
        if showGlitched {
            glitchedText
        } else {
            ImpossibleText()
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
    
    private var glitchedText: some View {
        VStack(spacing: 0) {
            ImpossibleText()
                .frame(height: textSize.height / 2, alignment: .top)
                .clipped()
                .offset(x: 1, y: 1)
            
            ImpossibleText()
                .frame(height: textSize.height / 2, alignment: .bottom)
                .clipped()
                .offset(x: -3)
            
        }
    }
}

#Preview {
    GlitchedText(showGlitched: true)
}
