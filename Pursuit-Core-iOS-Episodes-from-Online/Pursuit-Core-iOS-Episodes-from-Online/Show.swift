//
//  Show.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Matthew Ramos on 12/15/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowData: Decodable {
    let show: Show
}

struct Show: Decodable {
    let name: String
    let rating: Rating
    let image: Image
}

struct Rating: Decodable {
    let average: Double
}

struct Image: Decodable {
    let medium: String
    let original: String
}
