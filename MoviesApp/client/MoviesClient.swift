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
    
    func getMovies(page: Int, completion: @escaping ([Movie])->()) {
        
        Alamofire.request(moviesUrl+String(page)).responseJSON { response in
            
            if let data = response.data {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MoviesResponse.self, from: data)
                    print(response.results)
                    completion(response.results)
                }catch let er{
                    print("Err",er)
                }
            }
            
        }
    }
}
