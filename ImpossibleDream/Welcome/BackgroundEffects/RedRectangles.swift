//
//  RedRectangles.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI

struct RedRectangles: View {
    let timer = Timer.publish(every: 0.12, on: .main, in: .common).autoconnect()
    
    @State private var rectNum = 0
    
    var body: some View {
        ZStack {
            if rectNum == 0 {
                rect1
            } else if rectNum == 1 {
                rect2
            } else if rectNum == 2 {
                rect3
            }
            
            ImpossibleText()
                .foregroundStyle(.black)
        }
        .onAppear(perform: CoreHapticsManager.shared.prepareHaptics)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onReceive(timer) { input in
            rectNum = (rectNum + 1) % 3
        }
        .onChange(of: rectNum) { oldValue, newValue in
            if rectNum == 0 {
                CoreHapticsManager.shared.outlineHaptic()
            }
        }
    }
    
    private var rect1: some View {
        Rectangle()
            .strokeBorder(.red, lineWidth: 7)
            .frame(width: 350, height: 100)
            .rotationEffect(.degrees(2))
    }
    
    private var rect2: some View {
        Rectangle()
            .strokeBorder(
                style: StrokeStyle(
                    lineWidth: 4,
                    lineCap: .round,
                    lineJoin: .bevel,
                    miterLimit: 5,
                    dash: [10]
                )
            )
            .frame(width: 500, height: 150)
            .foregroundStyle(.red)
            .rotationEffect(.degrees(-1))
    }
    
    private var rect3: some View {
        Rectangle()
            .strokeBorder(
                style: StrokeStyle(
                    lineWidth: 8,
                    dash: [60]
                )
            )
            .frame(width: 550, height: 200)
            .foregroundStyle(.red)
            .rotationEffect(.degrees(1))
    }
}

#Preview {
    RedRectangles()
}
