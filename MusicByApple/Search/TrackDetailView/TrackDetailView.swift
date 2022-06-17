//
//  TrackDetailView.swift
//  MusicByApple
//
//  Created by lion on 17.06.22.
//

import UIKit

final class TrackDetailView: UIView {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackAuthorLAbel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trackImageView.backgroundColor = .systemCyan
    }
    
    @IBAction func dragDownButtonTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func handleCurrentTimeSlider(_ sender: UISlider) {
    }
    @IBAction func previousTrackTapped(_ sender: UIButton) {
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
    }
    
    @IBAction func nextTrackTapped(_ sender: UIButton) {
    }
    
    @IBAction func handleVolumeSlider(_ sender: UISlider) {
    }
    
}
