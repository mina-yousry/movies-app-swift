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

class MoviesHomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var moviesCollectionView: UICollectionView!
    @IBOutlet var moviesHomeViewModel: MoviesHomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //calling view model to fetch movies
        moviesHomeViewModel.fetchMovies(completion: { urls in
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
                SDWebImagePrefetcher.shared().prefetchURLs(urls)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesHomeViewModel.moviesCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        
        //setting cell image
        cell.moviePoster.sd_setImage(with: URL(string: self.moviesHomeViewModel.imageUrl(forItem: indexPath.item)), placeholderImage: UIImage(named: "default-placeholder.png"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //setting movie id in the next scene
        if segue.identifier == "movieDetails" {
            let nextScene =  segue.destination as! MovieDetailedController
            if let indexPath = moviesCollectionView.indexPathsForSelectedItems {
                let pressedMovieId = moviesHomeViewModel.movieId(forIndexPath: indexPath[0])
                nextScene.movieId = pressedMovieId
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //check if the user reached the last cells to fetch new movies
        if (indexPath.row == moviesHomeViewModel.moviesCount() - 2 ) {
            moviesHomeViewModel.fetchMovies(completion: {urls in
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                    SDWebImagePrefetcher.shared().prefetchURLs(urls)
                }
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //adjusting cell size according to collectionView size
        return CGSize(width: (self.moviesCollectionView.frame.width / 2)-5
            , height: self.moviesCollectionView.frame.width)
    }
}
