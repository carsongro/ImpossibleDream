//
//  ImpossibleText.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/17/24.
//

import SwiftUI

struct ImpossibleText: View {
    @State private var motion = MotionManager.shared
    
    var body: some View {
        Text("Impossible")
            .font(.system(size: 60))
            .fontWeight(.bold)
            .offset(x: motion.x * 14, y: motion.y * 14)
            .rotation3DEffect(.degrees(motion.x * 3), axis: (x: 0.0, y: 1.0, z: 0.0))
            .rotation3DEffect(.degrees(motion.y * 3), axis: (x: -1.0, y: 0.0, z: 0.0))
            .onAppear(perform: motion.addView)
            .onDisappear(perform: motion.removeView)
    }
}

#Preview {
    ImpossibleText()
}
