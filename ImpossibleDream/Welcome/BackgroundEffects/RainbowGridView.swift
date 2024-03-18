//
//  RainbowGridView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import SwiftUI

struct RainbowGridView: View, @unchecked Sendable {
    var body: some View {
        ZStack {
            gridView
            
            Text("Impossible")
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
        .background(.black)
        .ignoresSafeArea()
    }
    
    var rainbow: some View {
        Image(systemName: "rainbow")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .symbolRenderingMode(.multicolor)
            .symbolEffect(.variableColor.reversing.hideInactiveLayers)
            .frame(width: 100, height: 100)
    }
}

#Preview {
    RainbowGridView()
}
