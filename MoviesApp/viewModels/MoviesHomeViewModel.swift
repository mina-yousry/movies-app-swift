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
    
    func fetchMovies(completion: ()->()) {
        moviesClient.getMovies(page: 1, completion: { fetchedMovies in
            
        })
    }

}
