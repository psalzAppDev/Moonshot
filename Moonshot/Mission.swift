//
//  Mission.swift
//  Moonshot
//
//  Created by Peter Salz on 06.07.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        
        guard let launchDate = launchDate else {
            return "N/A"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        return formatter.string(from: launchDate)
    }
}
