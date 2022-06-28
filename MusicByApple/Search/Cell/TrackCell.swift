//
//  TrackCell.swift
//  MusicByApple
//
//  Created by lion on 17.06.22.
//

import UIKit
import SDWebImage


protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String? { get }
}

class TrackCell: UITableViewCell {
 
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addTrackButtonOutlet: UIButton!
    
    
    
    static let identifier = "TrackCell"
    var cell: SearchViewModel.Cell?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addTrackButton(_ sender: UIButton) {
    
        let userDefaults = UserDefaults.standard
        var listOfTracks = userDefaults.savedTracks()
        guard let cell = cell else { return }
        addTrackButtonOutlet.isHidden = true
        listOfTracks.append(cell)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks.self, requiringSecureCoding: false) {
            userDefaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
            print("save")
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = nil
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        
        self.cell = viewModel
        
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavorite = savedTracks.firstIndex(where: {$0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName}) != nil
        
        if hasFavorite {
            addTrackButtonOutlet.isHidden = true
        } else {
            addTrackButtonOutlet.isHidden = false
        }
                
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let iconUrlString = viewModel.iconUrlString, let url = URL(string:iconUrlString ) else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
        
    }
}
