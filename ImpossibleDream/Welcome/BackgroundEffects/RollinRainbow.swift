//
//  RollinRainbow.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/18/24.
//

import SwiftUI

struct RollinRainbowView: View {
    static let columns = 10
    
    @State private var gridColumns = Array(repeating: GridItem(.flexible(maximum: 40)), count: RollinRainbowView.columns)
    @State private var colors: [Color] = [.pink, .mint, .orange, .teal, .yellow, .cyan, .purple, .blue]
    @State private var scaleFactor : CGFloat = 1
    
    let numCircles = 300
    let repeatCount = 3
    let duration = 0.5
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridColumns) {
                ForEach(0..<numCircles, id: \.self) { index in
                    Circle()
                        .foregroundStyle(colors[index % colors.count])
                        .scaleEffect(scaleFactor)
                        .animation(.bouncy(duration: 0.5).delay((Double(index).truncatingRemainder(dividingBy: Double(RollinRainbowView.columns)) / 20)).repeatCount(repeatCount, autoreverses: true), value: scaleFactor)
                        .shadow(radius: (Double(index).truncatingRemainder(dividingBy: Double(RollinRainbowView.columns))))
                }
            }
        }
        .onAppear {
            CoreHapticsManager.shared.prepareHaptics()
            scaleFactor = 3
            CoreHapticsManager.shared.rollinRainbow()
        }
        .overlay {
            ImpossibleText()
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    RollinRainbowView()
}
