//
//  WelcomeVideoViewController.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import AVFoundation
import AVKit
import UIKit

class WelcomeVideoViewController: UIViewController {
    
    var player: AVPlayer?
    var layer: AVPlayerLayer?
    
    private let hapticsManager = CoreHapticsManager()
    private var timeObserver: Any?
    
    deinit {
        removePeriodicTimeObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hapticsManager.prepareHaptics()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let player = AVPlayer(url: URL(filePath: Bundle.main.path(forResource: "welcome", ofType: "mp4")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        self.layer = layer
        view.layer.addSublayer(layer)
        player.volume = 0
        self.player = player
        self.player?.play()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidEnd),
            name: AVPlayerItem.didPlayToEndTimeNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(resumeVideo),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        addPeriodicTimeObserver()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrame()
    }
    
    func updateFrame() {
        self.layer?.frame = view.bounds
    }
    
    @objc private func videoDidEnd() {
        player?.seek(to: .zero)
        player?.play()
    }
    
    @objc private func resumeVideo() {
        player?.play()
    }
    
    /// Adds an observer of the player timing.
    private func addPeriodicTimeObserver() {
        // Create a 0.5 second interval time.
        let interval = CMTime(value: 1, timescale: 4)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval,
                                                      queue: .main) { [weak self] time in
            guard let self else { return }
            // Update the published currentTime and duration values.
            let seconds = time.seconds
            playHaptics(for: seconds)
        }
    }

    /// Removes the time observer from the player.
    private func removePeriodicTimeObserver() {
        guard let timeObserver else { return }
        player?.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }
    
    private func playHaptics(for seconds: Double) {
        let range = (seconds - 0.075)...(seconds + 0.075)
        
        if range ~= 1.75 {
            hapticsManager.outlineHaptic()
        } else if range ~= 5.5 {
            hapticsManager.glitchHaptic()
        } else if range ~= 6.75 {
            hapticsManager.glitchHapticLong()
        } else if range ~= 9 {
            hapticsManager.rainbowHapticRising()
        } else if range ~= 9.75 {
            hapticsManager.rainbowHapticFalling()
        }
    }
}

#Preview {
    WelcomeVideoViewController()
}
