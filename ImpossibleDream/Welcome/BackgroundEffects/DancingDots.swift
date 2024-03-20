//
//  DancingDots.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/18/24.
//

import SwiftUI

@Observable
class SmallDot: Identifiable {
    let id = UUID()
    
    var offset: CGSize = .zero
    var color: Color = .primary
}

@Observable
class BigDot: Identifiable {
    let id = UUID()
    
    var offset: CGSize = .zero
    var color: Color = .primary
    var scale: Double = 1.0
    var smallDots = [SmallDot]()
    
    init() {
        for _ in 0..<5 {
            smallDots.append(SmallDot())
        }
    }
    
    func randomizePositions() {
        for dot in smallDots {
            dot.offset = CGSize(width: Double.random(in: -120...120), height: Double.random(in: -200...200))
            dot.color = DotTracker.randomColor
        }
    }
    
    func resetPositions() {
        for dot in smallDots {
            dot.offset = .zero
            dot.color = .primary
        }
    }
    
}

@Observable
class DotTracker {
    var bigDots = [BigDot]()
    
    static let colors: [Color] = [.pink, .purple, .mint, .blue, .yellow, .red, .teal, .cyan]
    static var randomColor: Color {
        colors.randomElement() ?? .blue
    }
    
    init() {
        for _ in 0..<50 {
            bigDots.append(BigDot())
        }
    }
    
    func randomizePositions() {
        for bigDot in bigDots {
            bigDot.offset = CGSize(width: Double.random(in: -50...50), height: Double.random(in: -100...100))
            bigDot.scale = 2.5
            bigDot.color = DotTracker.randomColor
            bigDot.randomizePositions()
        }
    }
    
    func resetPositions() {
        for bigDot in bigDots {
            bigDot.offset = .zero
            bigDot.scale = 1.0
            bigDot.color = DotTracker.randomColor
            bigDot.resetPositions()
        }
    }
    
}
struct DancingDotsView: View {
    private var columns = Array(repeating: GridItem(.flexible()), count: 10)
    @State var tracker = DotTracker()
    @State private var isAnimating = false
    @State private var textFrame: CGRect = .zero
    
    var body: some View {
        ImpossibleText()
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(isAnimating ? 1.1 : 1)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: isAnimating ? 0.33 : 0), radius: isAnimating ? 3 : 0, y: isAnimating ? 3 : 0)
            .background {
                LazyVGrid(columns: columns) {
                    ForEach(tracker.bigDots) { bigDot in
                        ZStack {
                            Circle()
                                .offset(bigDot.offset)
                                .foregroundColor(bigDot.color)
                                .scaleEffect(bigDot.scale)
                            ForEach(bigDot.smallDots) { smallDot in
                                Circle()
                                    .offset(smallDot.offset)
                                    .foregroundColor(smallDot.color)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .drawingGroup()
                .ignoresSafeArea()
            }
            .onAppear {
                CoreHapticsManager.shared.startEngine()
                
                withAnimation(.smooth(duration: 3)) {
                    CoreHapticsManager.shared.thunk()
                    isAnimating = true
                    tracker.randomizePositions()
                } completion: {
                    withAnimation(.snappy(duration: 0.2)) {
                        CoreHapticsManager.shared.thunk()
                        tracker.resetPositions()
                        isAnimating = false
                    }
                }
            }
    }
}

#Preview {
    DancingDotsView()
}
