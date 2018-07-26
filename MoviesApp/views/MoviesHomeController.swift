//
//  MoviesHomeController.swift
//  MoviesApp
//
//  Created by Mina  on 7/24/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "movieCell"

class MoviesHomeController: UICollectionViewController {
    
    @IBOutlet var moviesCollectionView: UICollectionView!
    @IBOutlet var moviesHomeViewModel: MoviesHomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        moviesHomeViewModel.fetchMovies(completion: {
            self.moviesCollectionView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesHomeViewModel.moviesCount()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
    
        cell.moviePoster.sd_setImage(with: URL(string: moviesHomeViewModel.imageUrl(forItem: indexPath.item)), placeholderImage: UIImage(named: "default-placeholder.png"))
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetails" {
            let nextScene =  segue.destination as! MovieDetailedController
            if let indexPath = moviesCollectionView.indexPathsForSelectedItems {
                let pressedMovieId = moviesHomeViewModel.movieId(forIndexPath: indexPath[0])
                nextScene.movieId = pressedMovieId
            }
        }
    }

}
