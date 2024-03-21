//
//  EruptEffect.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI

class EruptParticle {
    var x: Double
    var y: Double
    let xSpeed: Double
    let ySpeed: Double
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 2
    
    init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
        self.x = x
        self.y = y
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
    }
}
// TODO: Update for large screens
class EruptParticleSystem {
    var particles = [EruptParticle]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    func update(date: TimeInterval, size: CGSize, isFaster: Bool) {
        let delta = date - lastUpdate
        lastUpdate = date
        
        for (index, particle) in particles.enumerated() {
            if particle.deathDate < date {
                particles.remove(at: index)
            } else {
                particle.x += particle.xSpeed * delta
                particle.y += particle.ySpeed * delta
            }
        }
        
        let newParticle = EruptParticle(
            x: -32,
            y: isFaster ? .random(in: (size.height / 2 - 40)...size.height / 2 + 40) : size.height / 2,
            xSpeed: isFaster ? .random(in: 400...800) : .random(in: 0...300),
            ySpeed: isFaster ? .random(in: -75...75)  : .random(in: -75...75)
        )
        particles.append(newParticle)
    }
}


struct EruptEffect: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var particleSystem = EruptParticleSystem()
    @State private var showEruption = false
    
    var body: some View {
        ZStack {
            lavaView
            
            if showEruption {
                ImpossibleText()
                    .foregroundStyle(.black)
                    .opacity(0.9)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            CoreHapticsManager.shared.startEngine()
            CoreHapticsManager.shared.lavaInGround()
            Task {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                showEruption = true
                CoreHapticsManager.shared.lavaEruption()
            }
        }
        .mask(mask)
        .ignoresSafeArea()
        .background(.black)
    }
    
    private var lavaView: some View {
        LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing).mask {
            TimelineView(.animation) { timeline in
                Canvas { ctx, size in
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    particleSystem.update(date: timelineDate, size: size, isFaster: horizontalSizeClass == .regular)
                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    ctx.addFilter(.blur(radius: 10))
                    
                    ctx.drawLayer { ctx in
                        for particle in particleSystem.particles {
                            ctx.opacity = particle.deathDate - timelineDate
                            ctx.fill(Circle().path(in: CGRect(x: particle.x, y: particle.y, width: 32, height: 32)), with: .color(.white))
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var mask: some View {
        if showEruption {
            Rectangle()
        } else {
            ImpossibleText()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    EruptEffect()
}
