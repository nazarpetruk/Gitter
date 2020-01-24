//
//  TrendingRepoCell.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit

class TrendingRepoCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var repoImgView: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var numberOfForksLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var contributorsNmbrLbl: UILabel!
    @IBOutlet weak var toreadMeBtn: RoundedButton!
    @IBOutlet weak var backGroundView: UIView!
    
    
    //Variables
    
    private var repoUrl : String?
    
    func configCell(repo: Repository) {
        repoImgView.image = repo.img
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        numberOfForksLbl.text = String(repo.forksNmbr)
        languageLbl.text = repo.language
        contributorsNmbrLbl.text = String(repo.contributorsNmbr)
        repoUrl = repo.repoUrl
    }
    
    override func layoutSubviews() {
        backGroundView.layer.cornerRadius = 20
        backGroundView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backGroundView.layer.shadowOpacity = 0.25
        backGroundView.layer.shadowRadius = 5.0
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //trendingRepoCell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
