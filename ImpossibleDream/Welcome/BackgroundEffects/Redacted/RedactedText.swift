//
//  RedactedText.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/17/24.
//

import SwiftUI

struct RedactedText: View {
    @State private var textSize: CGSize = .zero
    @State private var redactedOffsetX: CGFloat = .zero
    @State private var showingRedacted = false
    
    var isGlitched: (Bool) -> Void
    
    var body: some View {
        ZStack {
            GlitchedTextEffect(
                upperLimit: 5,
                stages: [
                    0.0: nil,
                    1.0: 0.2,
                    1.2: nil,
                    3.0: 0.8,
                    3.8: nil,
                    4.4: 0.2,
                    4.6: nil
                ],
                isGlitched: isGlitched
            )
            .fixedSize(horizontal: true, vertical: false)
            .foregroundStyle(.red)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) {
                textSize = $0
                
                if !showingRedacted {
                    redactedOffsetX = -textSize.width
                }
                
                Task {
                    try await Task.sleep(nanoseconds: 0_500_000_000)
                    showingRedacted = true
                    withAnimation(.linear(duration: 5)) {
                        redactedOffsetX = 0
                    }
                }
            }
            
            Rectangle()
                .fill(.black)
                .clipped()
                .frame(width: textSize.width, height: textSize.height)
                .offset(x: redactedOffsetX)
                .opacity(showingRedacted ? 1 : 0)
            
            Rectangle()
                .frame(width: textSize.width, height: textSize.height)
                .offset(x: -textSize.width)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    RedactedText() { _ in }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .ignoresSafeArea()
}
