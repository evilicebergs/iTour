//
//  Destination.swift
//  iTour
//
//  Created by Artem Golovchenko on 2024-11-01.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    var toVisit: Bool
    @Relationship(deleteRule: .cascade) var sights = [Sight]()
    
    init(name: String = "", details: String = "", date: Date = .now , priority: Int = 2, toVisit: Bool = false) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
        self.toVisit = toVisit
    }
}
