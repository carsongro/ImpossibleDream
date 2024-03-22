//
//  MotionManager.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/19/24.
//

import Foundation
#if !os(macOS)
import CoreMotion

@Observable
class MotionManager: @unchecked Sendable {
    static let shared = MotionManager()
    
    private let motionManager = CMMotionManager()
    
    private var motionIsAvailable: Bool { motionManager.isDeviceMotionAvailable }
    
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
        guard motionIsAvailable else { return }
        
        motionManager.deviceMotionUpdateInterval = 1 / 120
    }
    
    private func start() {
        guard motionIsAvailable else { return }
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
        }
    }
    
    private func stop() {
        guard motionIsAvailable else { return }
        
        motionManager.stopDeviceMotionUpdates()
    }
    
    func addView() {
        guard motionIsAvailable else { return }
        
        viewCount += 1
    }
    
    func removeView() {
        guard motionIsAvailable else { return }
        
        viewCount -= 1
    }
}
#endif
