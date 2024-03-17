//
//  Goo.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI

class GooParticle {
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

class GooParticleSystem {
    var particles = [GooParticle]()
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
        
        let newParticle = GooParticle(x: .random(in: (size.width / 2 - 100)...size.width / 2 + 100), y: size.height / 2, xSpeed: .random(in: -100...100), ySpeed: .random(in: -125...125))
        particles.append(newParticle)
    }
}


struct Goo: View {
    @State private var particleSystem = GooParticleSystem()
    
    var body: some View {
        LinearGradient(colors: [.pink, .blue], startPoint: .top, endPoint: .bottom).mask {
            TimelineView(.animation) { timeline in
                Canvas { ctx, size in
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    particleSystem.update(date: timelineDate, size: size)
                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    ctx.addFilter(.blur(radius: 10))
                    
                    ctx.drawLayer { ctx in
                        for particle in particleSystem.particles {
                            ctx.opacity = particle.deathDate - timelineDate
                            ctx.fill(Circle().path(in: CGRect(x: particle.x, y: particle.y, width: 50, height: 50)), with: .color(.white))
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    Goo()
}
