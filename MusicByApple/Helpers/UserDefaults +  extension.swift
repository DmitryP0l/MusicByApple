//
//  UserDefaults +  extension.swift
//  MusicByApple
//
//  Created by lion on 28.06.22.
//

import Foundation

extension UserDefaults {
    
    static let favoriteTrackKey = "favoriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let userDefaults = UserDefaults.standard
        guard let savedTracks = userDefaults.object(forKey: UserDefaults.favoriteTrackKey) as? Data
        else { return [] }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else { return [] }
        return decodedTracks
    }
}
