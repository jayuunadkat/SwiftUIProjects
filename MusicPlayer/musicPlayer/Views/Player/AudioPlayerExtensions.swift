//
//  AudioPlayerExtensions.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 12/02/23.
//

import Foundation
import AVFAudio

extension AudioPlayerView {
    func initialiseAudioPlayer() {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [ .pad ]

        // init audioPlayer
        let path = Bundle.main.path(forResource: self.dashBoardVM.selectedData.song, ofType: "mp3")!
        self.dashBoardVM.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        self.dashBoardVM.audioPlayer!.prepareToPlay()

        //I need both! The formattedDuration is the string to display and duration is used when forwarding
        self.dashBoardVM.formattedDuration = formatter.string(from: TimeInterval(self.dashBoardVM.audioPlayer!.duration))!
        self.dashBoardVM.duration = self.dashBoardVM.audioPlayer!.duration

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if !self.dashBoardVM.audioPlayer!.isPlaying {
                self.dashBoardVM.isPlaying = false
            }
            self.dashBoardVM.progress = CGFloat(self.dashBoardVM.audioPlayer!.currentTime / self.dashBoardVM.audioPlayer!.duration)
            self.dashBoardVM.formattedProgress = formatter.string(from: TimeInterval(self.dashBoardVM.audioPlayer!.currentTime))!
        }
    }
}
