//
//  EpisodeData.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Matthew Ramos on 12/29/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Decodable {
    let name: String
    let season: Int
    let number: Int
    let image: EpisodeImage
}

struct EpisodeImage: Decodable {
    let medium: String
    let original: String
}
