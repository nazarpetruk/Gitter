//
//  DownloadService.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import Foundation
import Alamofire


class DownloadService {
    static let instance = DownloadService()
    
    
    func downloadTrendingRepositoriesArray(completion : @escaping (_ dictionaryArray : [Dictionary <String , Any>] ) -> ()) {
        var reposArray = [Dictionary<String, Any>]()
        Alamofire.request(trendingGitURL).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else {return}
            guard let repoDictionaryArray = json["items"] as? [Dictionary<String, Any>] else { return }
            for repoDict in repoDictionaryArray {
                if reposArray.count <= 9 {
                    reposArray.append(repoDict)
                }else{
                    break
                }
            }
            completion(reposArray)
        }
    }
    
    func dawnloadRepositories(completion: @escaping (_ repositoriesArray: [Repository]) -> ()){
        var repositArray = [Repository]()
        downloadTrendingRepositoriesArray { (trendingDictArray) in
            for dict in trendingDictArray {
               let repo = self.downloadRepositoryFromDictionary(fromDictionary: dict)
               repositArray.append(repo)
            }
             completion(repositArray)
        }
    }
    
    func downloadRepositoryFromDictionary(fromDictionary dict: Dictionary<String, Any> ) -> Repository {
//        let avatarUrl = dict["avatar_url"] as! String
        let name = dict["name"] as! String
        let descr = dict["description"] as! String
        let forksNbr = dict["forks_count"] as! Int
        let language = dict["language"] as? String ?? "JAVA"
        let numberOfContributors = dict[""]
        let repoURL = dict["html_url"] as! String
        
        let repos = Repository(name: name, image: UIImage(named: "searchIconLarge")!, descript: descr, forks: forksNbr, language: language, contributors: 1234, repoUrl: repoURL)
        
        return repos
    }
}
