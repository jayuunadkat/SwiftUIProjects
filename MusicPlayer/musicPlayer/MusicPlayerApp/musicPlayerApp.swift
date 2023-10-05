//
//  musicPlayerApp.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 11/02/23.
//

import SwiftUI

@main
struct musicPlayerApp: App {
    @StateObject var dashBoardVM: DashBoardViewModel = DashBoardViewModel()
    var body: some Scene {
        WindowGroup {
            DashBoardView()
                .environmentObject(self.dashBoardVM)
        }
    }
}
