//
//  MoviesClient.swift
//  MoviesApp
//
//  Created by Mina  on 7/24/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit
import Alamofire

class MoviesClient: NSObject {
    
    let moviesUrl = "https://api.themoviedb.org/3/discover/movie?api_key=ceb888b71023afda704f84975d2642b5&page="
    
    //this method returns movies from api according to page number
    func getMovies(page: Int, completion: @escaping ([Movie],Int)->()) {
        
        Alamofire.request(moviesUrl+String(page)).responseJSON { response in
            
            if let data = response.data {
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MoviesResponse.self, from: data)
                    completion(response.results,response.totalPages!)
                }catch let er{
                    print("Err",er)
                }
            }
            
        }
    }
}
