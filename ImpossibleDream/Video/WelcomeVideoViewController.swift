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
    var isPlaying = true {
        didSet {
            if isPlaying {
                playVideo()
            } else {
                pauseVideo()
            }
        }
    }
    
    private let hapticsManager = CoreHapticsManager.shared
    private var timeObserver: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        hapticsManager.prepareHaptics()
        
        let player = AVPlayer(url: URL(filePath: Bundle.main.path(forResource: "welcome", ofType: "mp4")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        self.layer = layer
        view.layer.addSublayer(layer)
        player.volume = 0
        self.player = player
        
        addObservers()
        
        if isPlaying {
            playVideo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isPlaying {
            playVideo()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrame()
    }
    
    func updateFrame() {
        self.layer?.frame = view.bounds
    }
    
    func playVideo() {
        player?.play()
        addPeriodicTimeObserver()
    }
    
    func pauseVideo() {
        player?.pause()
        removePeriodicTimeObserver()
    }
    
    /// Adds an observer of the player timing.
    private func addPeriodicTimeObserver() {
        // Create a 0.25 second interval time.
        let interval = CMTime(value: 1, timescale: 4)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval,
                                                      queue: .main) { [weak self] time in
            guard let self else { return }
            // Update the published currentTime and duration values.
            let seconds = time.seconds
            Task { @MainActor [weak self] in
                self?.playHaptics(for: seconds)
            }
        }
    }

    /// Removes the time observer from the player.
    private func removePeriodicTimeObserver() {
        guard let timeObserver else { return }
        player?.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }
    
    @MainActor
    private func playHaptics(for seconds: Double) {
        let range = (seconds - 0.075)...(seconds + 0.075)
        if range ~= 0 {
//            hapticsManager.rainbowHapticRising()
        } else if range ~= 0.5 {
//            hapticsManager.rainbowHapticFalling()
        } else if range ~= 4 {
            hapticsManager.outlineHaptic()
        } else if range ~= 7.25 {
            hapticsManager.glitchHapticLong()
        } else if range ~= 9.0 {
            hapticsManager.glitchHaptic()
        }
    }
}

// MARK: - Notification Center

extension WelcomeVideoViewController {
    private func addObservers() {
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    @objc private func videoDidEnd() {
        player?.seek(to: .zero)
        if isPlaying {
            player?.play()
        }
    }
    
    @objc private func resumeVideo() {
        if isPlaying {
            player?.play()
        }
    }
    
    @objc private func didBecomeActive() {
        hapticsManager.prepareHaptics()
    }
}

#Preview {
    WelcomeVideoViewController()
}
