//
//  VideoPlayerVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 22/09/23.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerVC: UIViewController {
    
    @IBOutlet weak var videoVw: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    
    var player: AVPlayer?
    var playerCOntroller = AVPlayerViewController()
    
    var strVideoUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        btnPlay.isHidden = true
        btnPause.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func playVideo() {
        let videoURL = URL(string: self.strVideoUrl)
        player = AVPlayer(url: videoURL!)
        playerCOntroller.player = player
        playerCOntroller.view.frame.size.height = self.videoVw.frame.size.height
        playerCOntroller.view.frame.size.width = self.videoVw.frame.size.width
        addChild(playerCOntroller)
        self.videoVw.addSubview(playerCOntroller.view)
        playerCOntroller.view.frame = self.videoVw.bounds
        playerCOntroller.didMove(toParent: self)
        self.videoVw.addSubview(playerCOntroller.view)
        player?.volume = 1.0
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
//        if !(player?.isPlaying ?? true){
//            player?.play()
//            btnPlay.isHidden = true
//            btnPause.isHidden = false
//        }
    }
    
    @IBAction func btnPause(_ sender: UIButton) {
//        if (player?.isPlaying ?? false){
//            player?.pause()
//            btnPlay.isHidden = false
//            btnPause.isHidden = true
//        }
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
