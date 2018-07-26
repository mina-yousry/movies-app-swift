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
    let imgUrlMaker = PosterPathMaker()
    
    //this method is used to get movies from api to view it in home
    //it also increases page count each time it's called
    func fetchMovies(completion: @escaping ([URL])->()) {
        var postersUrls: [URL] = []
        if firstTime{
            firstTime = false
            moviesClient.getMovies(page: pageCount, completion: { fetchedMovies,totalPages in
                for movie in fetchedMovies {
                    postersUrls.append(URL(string: self.imgUrlMaker.makeImgUrl(posterPath: movie.posterPath!))!)
                }
                self.movies.append(contentsOf: fetchedMovies)
                self.totalPages = totalPages
                completion(postersUrls)
            })
        }else{
            if pageCount<self.totalPages!{
                pageCount = pageCount+1
                moviesClient.getMovies(page: pageCount, completion: { fetchedMovies,totalPages in
                    for movie in fetchedMovies {
                        postersUrls.append(URL(string: self.imgUrlMaker.makeImgUrl(posterPath: movie.posterPath!))!)
                    }
                    self.movies.append(contentsOf: fetchedMovies)
                    completion(postersUrls)
                })
            }
        }
    }
    
    //this method returns poster url to a specific cell
    func imageUrl(forItem item: Int) -> String {
        if let path = movies[item].posterPath {
            return imgUrlMaker.makeImgUrl(posterPath: path)
        }else{
            return ""
        }
    }
    
    //this function returns number of movies
    func moviesCount() -> Int {
        return movies.count
    }
    
    
    //this method returns movie id to a specific cell
    func movieId(forIndexPath indexPath: IndexPath) -> Int {
        return movies[indexPath.item].id!
    }
    
}
