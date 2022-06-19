//
//  TrackDetailView.swift
//  MusicByApple
//
//  Created by lion on 17.06.22.
//

import UIKit
import SDWebImage
import AVKit

protocol TrackDetailViewDelegate: AnyObject {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell?
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell?
}

final class TrackDetailView: UIView {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackAuthorLAbel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var volumeMinImageView: UIImageView!
    @IBOutlet weak var volumeMaxImageView: UIImageView!
    
    weak var delegate: TrackDetailViewDelegate?
    
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
            self?.updateCurrentTimeSlider()
        }
    }
    
    private func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale:  1))
        let percentage = currentTimeSeconds / durationSeconds
        self.currentTimeSlider.value = Float(percentage)
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
        let percetage = currentTimeSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percetage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
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
    
    @IBAction func previousTrackTapped(_ sender: UIButton) {
        let cellViewModel = delegate?.moveBackForPreviousTrack()
        guard let cellViewModel = cellViewModel else { return }
        self.set(viewModel: cellViewModel)
        
    }
    
    @IBAction func nextTrackTapped(_ sender: UIButton) {
        let cellViewModel = delegate?.moveForwardForPreviousTrack()
        guard let cellViewModel = cellViewModel else { return }
        self.set(viewModel: cellViewModel)
    }
    
    @IBAction func handleVolumeSlider(_ sender: UISlider) {
        let volume = volumeSlider.value
        player.volume = volume
        if volume == 0.0 {
            volumeMinImageView.image = UIImage(systemName: "speaker.slash")
            volumeMaxImageView.image = UIImage(systemName: "speaker.zzz")
        } else if volume < 0.33 {
            volumeMinImageView.image = UIImage(systemName: "speaker")
            volumeMaxImageView.image = UIImage(systemName: "speaker.wave.1")
        } else if volume > 0.33 && volume < 0.66 {
            volumeMaxImageView.image = UIImage(systemName: "speaker.wave.2")
        } else if volume > 0.66 {
            volumeMaxImageView.image = UIImage(systemName: "speaker.wave.3")
        }
    }
}
