//
//  PosterPathMaker.swift
//  MoviesApp
//
//  Created by Mina  on 7/26/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit

// a class to create full image path from the api
class PosterPathMaker: NSObject {
    func makeImgUrl(posterPath: String) -> String {
        return "https://image.tmdb.org/t/p/w500/"+posterPath
    }
}
