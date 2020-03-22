//
//  ViewController.swift
//  PictureInPictureVideoPlayer-Ipd
//
//  Created by Harshal on 22/03/20.
//  Copyright © 2020 Harshal. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    var playerController: AVPlayerViewController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func play(_ sender: UIButton) {
        let url = Bundle.main.url(forResource: "Apple", withExtension: "mp4")
        let player = AVPlayer(url: url!)
        playerController = AVPlayerViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.didfinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.delegate = self
        playerController.player?.play()
        self.present(playerController, animated: true, completion: nil)
    }
    
    @objc func didfinishPlaying(note : NSNotification)  {
        playerController.dismiss(animated: true, completion: nil)
        let alertView = UIAlertController(title: "Finished", message: "Video finished", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: AVPlayerViewControllerDelegate {
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        let currentVC = navigationController?.visibleViewController
        if currentVC != playerViewController {
            currentVC?.present(playerViewController, animated: true, completion: nil)
        }
    }
}
