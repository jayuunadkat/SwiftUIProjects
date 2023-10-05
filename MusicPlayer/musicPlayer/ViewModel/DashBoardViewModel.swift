//
//  DashBoardViewModel.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 12/02/23.
//

import Foundation
import AVFoundation
import SwiftUI

class DashBoardViewModel: ObservableObject {
    @Published var isSheetOpened: Bool = false
    @Published var selectedData: Songs =
    Songs(
        image: Constants.Image.kBones,
        name: "Bones",
        artists: "Imagine Dragons",
        song: Constants.Audio.kBonesSong
    )
    @Published var isPlaying: Bool = false
    @Published var audioPlayer: AVAudioPlayer?
    @Published var progress: CGFloat = 0.0
    @Published var duration: Double = 0.0
    @Published var formattedDuration: String = ""
    @Published var formattedProgress: String = "00:00"
    
    func updateTimer(value: Double) {
        if value > 0 {
            let total = self.progress + value
            if total > 1.0 {
                self.progress = 1.0
            } else {
                self.progress = total
            }
                
                
        } else if value < 0{
            let total = self.progress + value
            if total < 0 {
                self.progress = 0.0
            } else {
                self.progress = total
            }
        }
        self.audioPlayer?.currentTime = self.duration * self.progress
    }
}
