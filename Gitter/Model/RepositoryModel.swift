//
//  RepositoryModel.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit


class Repository {
    
    public private(set) var name : String
    public private(set) var description : String
    public private(set) var forksNmbr : Int
    public private(set) var language : String
    public private(set) var contributorsNmbr : Int
    public private(set) var repoUrl : String
    public private(set) var img : UIImage
    
    init(name: String, image: UIImage, descript: String, forks: Int, language: String, contributors: Int, repoUrl: String) {
        self.name = name
        self.img = image
        self.description = descript
        self.forksNmbr = forks
        self.language = language
        self.contributorsNmbr = contributors
        self.repoUrl = repoUrl
    }
}
