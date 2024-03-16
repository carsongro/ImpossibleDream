//
//  RainbowGridView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import SwiftUI

struct RainbowGridView: View {
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(0..<10) { _ in
                GridRow {
                    ForEach(0..<10) { _ in
                        rainbow
                            .rotationEffect(.degrees([0.0, 90.0, 180.0, 270.0].randomElement()!))
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
            .symbolEffect(
                .variableColor
                .reversing
                .hideInactiveLayers
            )
            .frame(width: 100, height: 100)
    }
}

#Preview {
    RainbowGridView()
}
