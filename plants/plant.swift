//
//  plant.swift
//  plants
//
//  Created by sumaya alawad on 07/05/1447 AH.
//

import Foundation

struct Plant: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var location: String
    var sun: String
    var water: String
    var isWatered: Bool
}
