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
        
//        moviePoster.layer.shadowColor = UIColor.darkGray.cgColor
//        moviePoster.layer.shadowOpacity = 1
//        moviePoster.layer.shadowPath = self.shadowCurvedForView(givenView: moviePoster,curvedPercent: 0.3).cgPath
//        moviePoster.layer.shadowRadius = 5
        
        if let id = movieId {
            print(id)
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
        // Dispose of any resources that can be recreated.
    }
    
    func setViews(movie: DetailedMovie) {
        
        moviePoster.contentMode = UIViewContentMode.scaleAspectFill
        moviePoster.clipsToBounds = true
        moviePoster.sd_setImage(with: URL(string: movie.posterUrl()), placeholderImage: UIImage(named: "default-placeholder.png"))
        
        if let budget = movie.budget {
            budgetLbl.text = String(budget)+"$"
        }
        
        if let title = movie.title {
            movieNameLbl.text = title
            self.title = title
        }
        
        if let rate = movie.voteAverage {
            ratingView.rating = rate/2.0
            print(rate/2.0)
        }
        
        if let date = movie.releaseDate {
            var dateParts = date.components(separatedBy: "-")
            movieYearLbl.text = dateParts[0]
        }
        
        budgetBG.layer.cornerRadius = (budgetBG.frame.height)/2
        budgetBG.layer.masksToBounds=true
        budgetBG.layer.borderWidth=3
        budgetBG.layer.borderColor = UIColor.lightGray.cgColor
        if movie.genres.count > 0 {
            var genersText = movie.genres[0].name!
            if movie.genres.count>1{
                for i in 1 ... (movie.genres.count-1){
                    genersText += (" / " + movie.genres[i].name!)
                }
            }
            movieGenersLbl.text = genersText
        }
        
        if let overview = movie.overview {
            movieOverviewTxt.text = overview
        }
    }
    
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
//    func shadowCurvedForView(givenView: UIView, curvedPercent:CGFloat) ->UIBezierPath
//    {
//        let arrowPath = UIBezierPath()
//
//        arrowPath.move(to: CGPoint(x:0, y:0))
//
//        arrowPath.addLine(to: CGPoint(x:screenWidth, y:0))
//
//        arrowPath.addLine(to: CGPoint(x:screenWidth, y:(givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent))+30))
//
//        arrowPath.addQuadCurve(to: CGPoint(x:0, y:(givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)+30)), controlPoint: CGPoint(x:screenWidth/2, y:givenView.bounds.size.height))
//
//        arrowPath.addLine(to: CGPoint(x:0, y:0))
//
//        arrowPath.close()
//
//        return arrowPath
//    }
}

//extension MovieDetailedController{
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let movie = self.displayedMovie {
//            return movie.productionCompanies.count
//        }else{
//            return 0
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyCell
//
//        if let movie = self.displayedMovie {
//            cell.companyImage.layer.cornerRadius = (budgetBG.frame.height)/2
//            cell.companyImage.sd_setImage(with: URL(string: movie.productionCompanies[indexPath.row].logoPath!), placeholderImage: UIImage(named: "default-placeholder.png"))
//            cell.companyName.text = movie.productionCompanies[indexPath.row].name
//        }
//
//        return cell
//    }
//
//}

