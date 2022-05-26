//
//  Model.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI
import Foundation

struct Model: Decodable {
    
    var id: Int?
    
    let date: String
    let title: String
    let body: String
    let rating: Double
    let emoji: String
}
