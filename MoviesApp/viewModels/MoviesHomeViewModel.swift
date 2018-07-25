//
//  MoviesHomeViewModel.swift
//  MoviesApp
//
//  Created by Mina  on 7/24/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit

class MoviesHomeViewModel: NSObject {
    
    @IBOutlet var moviesClient: MoviesClient!
    var movies = [Movie]()
    
    func fetchMovies(completion: @escaping ()->()) {
        moviesClient.getMovies(page: 1, completion: { fetchedMovies in
            self.movies.append(contentsOf: fetchedMovies)
            completion()
        })
    }
    
    func imageUrl(forItem item: Int) -> String {
        return movies[item].posterUrl()
    }
    
    func moviesCount() -> Int {
        return movies.count
    }

}
