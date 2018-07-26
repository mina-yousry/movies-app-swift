//
//  MovieDetailedController.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class MovieDetailedController: UITableViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var budgetLbl: UILabel!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieYearLbl: UILabel!
    @IBOutlet weak var movieGenersLbl: UILabel!
    @IBOutlet weak var movieOverviewTxt: UITextView!
    @IBOutlet weak var budgetBG: UIImageView!
    @IBOutlet weak var productionCell: UITableViewCell!
    @IBOutlet weak var productionCompaniesTableView: UITableView!
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet var movieDetailsViewModel: MovieDetailsViewModel!
    @IBOutlet var productionController: productionTableViewController!
    
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set navigation bar buttons
        let heartImage    = UIImage(named: "heart.png")!
        let shareImage  = UIImage(named: "share.png")!
        let likeButton   = UIBarButtonItem(image: heartImage,  style: .plain, target: self, action: #selector(MovieDetailedController.didTapLikeButton))
        let shareButton = UIBarButtonItem(image: shareImage,  style: .plain, target: self, action: #selector(MovieDetailedController.didTapShareButton))
        navigationItem.rightBarButtonItems = [shareButton, likeButton]
        
        //fetching movie details
        if let id = movieId {
            movieDetailsViewModel.movie(withId: id, completion: {movie in
                self.setViews(movie: movie)
                self.productionController.productionCompanies = movie.productionCompanies
                self.productionCompaniesTableView.reloadData()
            })
        }else{
            print("nil")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //set the view according to movie details
    func setViews(movie: DetailedMovie) {
        
        //setting movie poster
        let imgUrlMaker = PosterPathMaker()
        moviePoster.contentMode = UIViewContentMode.scaleAspectFill
        if let path = movie.posterPath {
            moviePoster.sd_setImage(with: URL(string: imgUrlMaker.makeImgUrl(posterPath: path)), placeholderImage: UIImage(named: "default-placeholder.png"))
        }
        
        //budget label
        if let budget = movie.budget {
            budgetLbl.text = String(budget)+"$"
        }
        
        //movie title label
        if let title = movie.title {
            movieNameLbl.text = title
            self.title = title
        }
        
        //setting rate view
        if let rate = movie.voteAverage {
            ratingView.rating = rate/2.0
        }
        
        //setting date
        if let date = movie.releaseDate {
            var dateParts = date.components(separatedBy: "-")
            movieYearLbl.text = dateParts[0]
        }
        
        //setting budegt background image
        budgetBG.layer.cornerRadius = (budgetBG.frame.height)/2
        budgetBG.layer.masksToBounds=true
        budgetBG.layer.borderWidth=3
        budgetBG.layer.borderColor = UIColor.lightGray.cgColor
        
        //movie generes label
        if movie.genres.count > 0 {
            var genersText = movie.genres[0].name!
            if movie.genres.count>1{
                for i in 1 ... (movie.genres.count-1){
                    genersText += (" / " + movie.genres[i].name!)
                }
            }
            movieGenersLbl.text = genersText
        }
        
        //overview text
        if let overview = movie.overview {
            movieOverviewTxt.text = overview
        }
    }
    
    @objc func didTapShareButton() {
        //something to do when share button is pressed
        print("Share button clicked")
    }
    
    @objc func didTapLikeButton() {
        //something to do when like button is pressed
        print("Like button clicked")
    }
}

