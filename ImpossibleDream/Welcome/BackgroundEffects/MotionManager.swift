//
//  MotionManager.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/19/24.
//

import Foundation
import CoreMotion

@Observable
class MotionManager: @unchecked Sendable {
    static let shared = MotionManager()
    
    private let motionManager = CMMotionManager()
    
    private var viewCount = 0 {
        didSet {
            if viewCount == 1 {
                start()
            } else if viewCount == 0 {
                stop()
            }
        }
    }
    
    var x = 0.0
    var y = 0.0
    
    private init() {
        motionManager.deviceMotionUpdateInterval = 1 / 120
    }
    
    private func start() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
        }
    }
    
    private func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func addView() {
        viewCount += 1
    }
    
    func removeView() {
        viewCount -= 1
    }
}
