//
//  CoreHapticsManager.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import CoreHaptics
import Foundation

final class CoreHapticsManager: @unchecked Sendable {
    static let shared = CoreHapticsManager()
    
    private init() { }
    
    private var engine: CHHapticEngine?
    
    func rollinRainbow() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0.0, to: 0.6, by: 0.06) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.25)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 2)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0.0, to: 0.9, by: 0.09) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.25)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 2)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i + 0.9)
            events.append(event)
        }
        
        for i in stride(from: 0.0, to: 1.6, by: 0.16) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.25)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 2)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i + 1.6)
            events.append(event)
        }
        
        playEvents(events: events)
    }
    
    func lavaInGround() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity,value: 0.8)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
        let continuousEvent = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 2)
        events.append(continuousEvent)
        
        playEvents(events: events)
    }
    
    func lavaEruption() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 2, by: 0.05) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 2)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        playEvents(events: events)
    }
    
    func glitchHaptic(duration: Double) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: duration, by: 0.03) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        playEvents(events: events)
    }
    
    func outlineHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 2)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 2)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        playEvents(events: events)
    }
    
    func rainbow() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0.36, to: 1.1, by: 0.18) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i / 2))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i / 2))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0.54, to: 1.325, by: 0.18) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i / 2))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i / 2))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1.25 + i)
            events.append(event)
        }
        
        playEvents(events: events)
    }
    
    func playEvents(events: [CHHapticEvent]) {
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
}
