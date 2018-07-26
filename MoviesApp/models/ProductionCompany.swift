//
//  ProductionCompany.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit

class ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    func logoUrl() -> String {
        if let relativeUrl = self.logoPath {
            return "https://image.tmdb.org/t/p/w500/"+relativeUrl
        }else{
            return ""
        }
    }
}
