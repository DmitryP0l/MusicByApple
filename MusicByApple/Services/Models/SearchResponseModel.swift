//
//  SearchResponseModel.swift
//  MusicByApple
//
//  Created by lion on 11.06.22.
//

import Foundation

struct TrackModel{
    var trackName: String
    var artistName: String
}

struct SearchResponseModel: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable {
    var artistName: String
    var trackName: String
    var collectionName: String?
    var artworkUrl100: String?
    var previewUrl: String?
}
