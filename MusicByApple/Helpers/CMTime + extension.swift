//
//  CMTime + extension.swift
//  MusicByApple
//
//  Created by lion on 19.06.22.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return ""}
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minuts = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minuts, seconds)
        return timeFormatString
    }
}
