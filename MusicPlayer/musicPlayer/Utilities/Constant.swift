//
//  Constant.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 11/02/23.
//

import Foundation
import UIKit

//MARK: - CONSTANTS
struct Constants {
    
    //MARK: - IMAGES
    struct Image {
       static let kPause: String        = "pause.fill"
       static let kRefresh: String      = "arrow.clockwise.circle"
       static let kPanda: String        = "Panda"
       static let kEdSheeran: String    = "EdSheeran"
       static let kAliceChains: String  = "AliceChains"
       static let kBones: String        = "Bones"
       static let kNights: String       = "Nights"
       static let kPassenger: String    = "Passenger"
       static let kShapeOfYou: String   = "ShapeOfYou"
    }
    
    //MARK: - AUDIO
    struct Audio {
        static let kShapeOfYouSong: String      = "ShapeOfYouSong"
        static let kBonesSong: String           = "BonesSong"
        static let kPassengerSong: String           = "PassengerSong"
        static let kNightsSong: String          = "TheNightsSong"
    }
    
    //MARK: - DESCRIPTIONS
    struct Descriptions {
        static let kNavigationBarText   = "Hey, Jaymeen!!"
        static let kArtistsOfWeek       = "ARTISTS OF THE WEEK"
        static let kTopCharts           = "TOP CHARTS"
        static let kSeeAll              = "See All"
    }
    
    static let SCREEN_WIDTH     = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT    = UIScreen.main.bounds.height
}
