//
//  SearchResultCell.swift
//  Gitter
//
//  Created by Nazar Petruk on 26/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var repositoryNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var forksNbrLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var backgroundVIEW: UIView!
    
    
    //MARK: Variables
    private var repoUrl : String?
    
    
    func configureCell(repository : Repository) {
        
        repositoryNameLbl.text = repository.name
        descriptionLbl.text = repository.description
        forksNbrLbl.text = String(repository.forksNmbr)
        languageLbl.text = repository.language
        repoUrl = repository.repoUrl
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundVIEW.layer.cornerRadius = 15
    }
}
  
