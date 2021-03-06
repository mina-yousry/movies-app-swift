//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit

class MovieDetailsViewModel: NSObject {

    @IBOutlet var movieDetailsClient: MovieDetailsClient!
    
    //this function calls the client to get details about a movie
    func movie(withId id: Int,completion:@escaping (DetailedMovie)->()) {
        movieDetailsClient.movie(withId: id, completion: {movie in
            completion(movie)
        })
    }
}
