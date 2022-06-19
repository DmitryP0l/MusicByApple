//
//  TrackDetailView.swift
//  MusicByApple
//
//  Created by lion on 17.06.22.
//

import UIKit
import SDWebImage
import AVKit

final class TrackDetailView: UIView {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackAuthorLAbel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    let player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTrackImageView()
    }
    
//MARK: - Setup
    
    private func setTrackImageView() {
        trackImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        trackImageView.layer.cornerRadius = 8
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        trackTitleLabel.text = viewModel.trackName
        trackAuthorLAbel.text = viewModel.artistName
        
        playTrack(previewUrl: viewModel.previewUrl)
        monitorStartTime()
        observePlayerCurrentTime()
        
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func playTrack(previewUrl: String?) {
        
        guard let previewUrl = previewUrl, let url = URL(string: previewUrl) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
//MARK: - Time setup
    
    private func monitorStartTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.enlagreTrackImageView()
        }
    }
    
    private func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTimeLabel.text = time.toDisplayString()
            
            let durationTime = self?.player.currentItem?.duration
            let currentDurationTimeText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            self?.durationTimeLabel.text = "-\(currentDurationTimeText)"
        }
    }
    
//MARK: - Animations
    
    private func enlagreTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.trackImageView.transform = .identity
            self.trackImageView.layer.cornerRadius = 8
        } completion: { _ in }

    }
    
    private func reduceTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.setTrackImageView()
        } completion: { _ in }

    }
    
}


//MARK: - @IBActions

extension TrackDetailView {
    
    @IBAction func dragDownButtonTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func handleCurrentTimeSlider(_ sender: UISlider) {
    }
    
    @IBAction func previousTrackTapped(_ sender: UIButton) {
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            enlagreTrackImageView()
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            reduceTrackImageView()
        }
    }
    
    @IBAction func nextTrackTapped(_ sender: UIButton) {
    }
    
    @IBAction func handleVolumeSlider(_ sender: UISlider) {
    }
}
