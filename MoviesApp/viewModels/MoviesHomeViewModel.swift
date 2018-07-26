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
    var firstTime = true
    var pageCount = 1
    var totalPages: Int?
    
    func fetchMovies(completion: @escaping ()->()) {
        if firstTime{
            firstTime = false
            moviesClient.getMovies(page: pageCount, completion: { fetchedMovies,totalPages in
                self.movies.append(contentsOf: fetchedMovies)
                self.totalPages = totalPages
                completion()
            })
        }else{
            if pageCount<self.totalPages!{
                pageCount = pageCount+1
                moviesClient.getMovies(page: pageCount, completion: { fetchedMovies,totalPages in
                    self.movies.append(contentsOf: fetchedMovies)
                    completion()
                })
            }
        }
    }
    
    func imageUrl(forItem item: Int) -> String {
        let imgUrlMaker = PosterPathMaker()
        if let path = movies[item].posterPath {
            return imgUrlMaker.makeImgUrl(posterPath: path)
        }else{
            return ""
        }
    }
    
    func moviesCount() -> Int {
        return movies.count
    }
    
    func movieId(forIndexPath indexPath: IndexPath) -> Int {
        return movies[indexPath.item].id!
    }
    
}
