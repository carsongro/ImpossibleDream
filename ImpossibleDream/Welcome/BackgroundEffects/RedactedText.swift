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
    
    var body: some View {
        ZStack {
            GlitchedText(
                upperLimit: 5,
                stages: [
                    0.0: nil,
                    1.0: 0.6,
                    1.6: nil,
                    3.0: 1.0,
                    4.0: nil
                ]
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
                    try await Task.sleep(nanoseconds: 1_000_000_000)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    RedactedText()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .ignoresSafeArea()
}
