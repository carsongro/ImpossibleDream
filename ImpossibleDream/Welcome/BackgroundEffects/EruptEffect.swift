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

class EruptParticleSystem {
    var particles = [EruptParticle]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    func update(date: TimeInterval, size: CGSize) {
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
            y: size.height / 2,
            xSpeed: .random(in: 0...300),
            ySpeed: .random(in: -75...75)
        )
        particles.append(newParticle)
    }
}


struct EruptEffect: View {
    @State private var particleSystem = EruptParticleSystem()
    @State private var currentTime = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var showEruption: Bool { currentTime > 1 }
    
    var body: some View {
        ZStack {
            lavaView
            
            // TODO: Add tilt
            if showEruption {
                Text("Impossible")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .opacity(0.9)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear(perform: CoreHapticsManager.shared.prepareHaptics)
        .onReceive(timer) {
            currentTime = Int($0.timeIntervalSinceReferenceDate) % 4
            if currentTime == 0 {
                CoreHapticsManager.shared.lavaInGround()
            } else if currentTime == 2 {
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
                    particleSystem.update(date: timelineDate, size: size)
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
            Text("Impossible")
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .opacity(1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    EruptEffect()
}
