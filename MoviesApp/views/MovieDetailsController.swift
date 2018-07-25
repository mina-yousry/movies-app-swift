//
//  MovieDetailsController.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit

class MovieDetailsController: UIViewController {
    
    @IBOutlet var movieDetailsViewModel: MovieDetailsViewModel!
    
    var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = movieId {
            print(id)
            movieDetailsViewModel.movie(withId: id, completion: {movie in
                
            })
        }else{
            print("nil")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
