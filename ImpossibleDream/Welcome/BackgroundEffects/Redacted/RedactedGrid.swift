//
//  RedactedGrid.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/17/24.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct RedactedGrid: View, @unchecked Sendable {
    @State private var isGlitched = false
    @State private var showGlitchedText = true
    
    var body: some View {
        ZStack {
            RedactedText() { 
                isGlitched = $0
                if isGlitched {
                    showGlitchedText.toggle()
                }
            }
            
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<11) { _ in
                    GridRow {
                        ForEach(0..<11) { _ in
                            gridText
                        }
                    }
                }
                
                GridRow {
                    ForEach(0..<5) { _ in
                        gridText
                    }
                    
                    ImpossibleText()
                        .foregroundStyle(.clear)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    ForEach(0..<5) { _ in
                        gridText
                    }
                }
                
                ForEach(0..<11) { _ in
                    GridRow {
                        ForEach(0..<11) { _ in
                            gridText
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .opacity(isGlitched ? 1 : 0)
        }
    }
    
    private var gridText: some View {
        GlitchedText(text: "Impossible", showGlitched: showGlitchedText)
            .foregroundStyle(.black)
            .fixedSize(horizontal: true, vertical: false)
            .background(.white)
    }
}

#Preview {
    RedactedGrid()
}