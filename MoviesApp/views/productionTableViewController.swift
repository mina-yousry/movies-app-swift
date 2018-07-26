//
//  TableViewController.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit
import SDWebImage

class productionTableViewController: UITableViewController {

    var productionCompanies: [ProductionCompany]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let companies = productionCompanies {
            return companies.count
        }else{
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyCell
        
        //setting company logo UIImageView
        cell.companyImage.layer.cornerRadius = (cell.companyImage.frame.height)/2
        cell.companyImage.layer.masksToBounds=true
        cell.companyImage.layer.borderWidth=3
        cell.companyImage.layer.borderColor = UIColor.lightGray.cgColor
        
        if let companies = productionCompanies{
            if let path = companies[indexPath.row].logoPath {
                let imgUrlMaker = PosterPathMaker()
                //set company logo image
            cell.companyImage.sd_setImage(with: URL(string: imgUrlMaker.makeImgUrl(posterPath: path)), placeholderImage: UIImage(named: "default-placeholder.png"))
            }
            //set company name
            cell.companyName.text = companies[indexPath.row].name
        }
        
        return cell
    }
    
    //setting cell he
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
