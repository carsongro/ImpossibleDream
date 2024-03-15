//
//  VideoPlayerViewController.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import AVFoundation
import AVKit
import UIKit

class VideoPlayerViewController: UIViewController {
    
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let player = AVPlayer(url: URL(filePath: Bundle.main.path(forResource: "welcome", ofType: "mp4")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
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
    }
    
    @objc private func videoDidEnd() {
        player?.seek(to: .zero)
        player?.play()
    }
    
    @objc private func resumeVideo() {
        player?.play()
    }
}

#Preview {
    VideoPlayerViewController()
}
