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
    
    func movie(withId id: Int, completion: @escaping (DetailedMovie)->()) {
        
        Alamofire.request(movieUrl+String(id)+urlKey).responseJSON { response in
            
            if let data = response.data {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
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
