//
//  RainbowGridView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import SwiftUI

struct RainbowGridView: View, @unchecked Sendable {
    @State private var rainbowOpacity = 0.0
    
    var body: some View {
        ZStack {
            gridView
            
            ImpossibleText()
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .drawingGroup()
        .onAppear(perform: CoreHapticsManager.shared.rainbow)
    }
    
    @ViewBuilder
    private var gridView: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(0..<5) { _ in
                GridRow {
                    ForEach(0..<10) { _ in
                        rainbow
                            .rotationEffect(.degrees(180))
                    }
                }
            }
            ForEach(0..<5) { _ in
                GridRow {
                    ForEach(0..<10) { _ in
                        rainbow
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 0_265_000_000)
                rainbowOpacity = 1.0
            }
        }
    }
    
    var rainbow: some View {
        Image(systemName: "rainbow")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .symbolRenderingMode(.multicolor)
            .symbolEffect(.variableColor.reversing.hideInactiveLayers)
            .frame(width: 100, height: 90)
            .opacity(rainbowOpacity)
    }
}

#Preview {
    RainbowGridView()
}
