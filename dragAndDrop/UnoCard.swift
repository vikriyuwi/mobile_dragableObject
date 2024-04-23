//
//  UnoCard.swift
//  dragAndDrop
//
//  Created by win win on 22/04/24.
//

import Foundation
import SwiftData

@Model
class UnoCard {
    var color:String
    var identity:String
    var owner:String
    init(color: String, identity: String, owner: String) {
        self.color = color
        self.identity = identity
        self.owner = owner
    }
}
