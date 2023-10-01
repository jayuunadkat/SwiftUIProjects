//
//  OrderAttributes.swift
//  LiveActivities
//
//  Created by differenz239 on 25/09/23.
//

import SwiftUI
// MARK: - Available from XCode 14 Beta 4
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    public struct ContentState: Codable,Hashable {
        // MARK: - live activities will update it's view when content state is updated
        var status: Status = .received
    }
    
    // MARK: - Other Properties
    var orderNumber: Int
    var orderItems: String
}

// MARK: - Order Status
enum Status: String, CaseIterable, Codable, Equatable{
    // MARK: - string values are SFSymbol Images
    case received = "shippingbox.fill"
    case progress = "person.bust"
    case ready = "takeoutbag.and.cup.and.straw.fill"
}
