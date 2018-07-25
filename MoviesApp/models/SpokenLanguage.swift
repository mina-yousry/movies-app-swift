//
//  SpokenLanguage.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit

class SpokenLanguage: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
