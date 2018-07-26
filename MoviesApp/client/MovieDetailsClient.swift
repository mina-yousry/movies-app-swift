//
//  MovieDetailsClient.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailsClient: NSObject {
    
    let movieUrl = "https://api.themoviedb.org/3/movie/"
    let urlKey = "?api_key=ceb888b71023afda704f84975d2642b5"
    
    //this method gets the details of a specific movie from the api
    func movie(withId id: Int, completion: @escaping (DetailedMovie)->()) {
        
        Alamofire.request(movieUrl+String(id)+urlKey).responseJSON { response in
            
            if let data = response.data {
                do{
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(DetailedMovie.self, from: data)
                    print(movie.originalTitle!)
                    completion(movie)
                }catch let er{
                    print("Err",er)
                }
            }
            
        }
    }
    
}
