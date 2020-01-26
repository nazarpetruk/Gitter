//
//  DownloadService.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class DownloadService {
    static let instance = DownloadService()
    
    
    func downloadTrendingRepositoriesDictionaryArray(completion : @escaping (_ dictionaryArray : [Dictionary <String , Any>] ) -> ()) {
        var reposArray = [Dictionary<String, Any>]()
        
        Alamofire.request(trendingGitURL).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else {return}
            
            guard let repoDictionaryArray = json["items"] as? [Dictionary<String, Any>] else { return }
            //print(repoDictionaryArray)
            
            for repoDict in repoDictionaryArray.dropFirst() {
                if reposArray.count <= 10 {
                    guard let name = repoDict["name"] as? String,
                        let description = repoDict["description"] as? String,
                        let forksNbr = repoDict["forks_count"] as? Int,
                        let language = repoDict["language"] as? String ,
                        let repoURL = repoDict["html_url"] as? String,
                        let contributorsURL = repoDict["contributors_url"] as? String,
                        let ownerDict = repoDict["owner"] as? Dictionary<String, Any>,
                        let avatarUrl = ownerDict["avatar_url"] as? String else { continue }
                    
                    let repoDictionary : Dictionary <String, Any> =
                        ["name" : name, "description" : description, "forks_count" : forksNbr, "language" : language, "html_url" : repoURL, "contributors_url" : contributorsURL, "avatar_url" : avatarUrl]
                    reposArray.append(repoDictionary)
                }else{
                    break
                }
            }
            completion(reposArray)
        }
    }
    
    func downloadTrendingRepositories(completion: @escaping (_ reposArray: [Repository]) -> ()) {
        var reposArray = [Repository]()
        downloadTrendingRepositoriesDictionaryArray { (trendingReposDictArray)
            in
            for dict in trendingReposDictArray {
                self.downloadRepositoryFromDictionary(fromDictionary: dict, completion: {
                    (returnedRepo) in
                    if reposArray.count < 10 {
                        reposArray.append(returnedRepo)
                    }else{
                        let sortedArrayOfRepositories = reposArray.sorted { (repA, repB) -> Bool in
                            if repA.forksNmbr > repB.forksNmbr {
                                return true
                            }else{
                                return false
                            }
                        }
                        completion(sortedArrayOfRepositories)
                    }
                })
            }
        }
    }
    
    func downloadRepositoryFromDictionary(fromDictionary dict: Dictionary<String, Any>, completion : @escaping (_ repository : Repository) -> ())  {
        
        let avatarUrl = dict["avatar_url"] as! String
        let numberOfContributorsURL = dict["contributors_url"] as! String
        let name = dict["name"] as! String
        let descr = dict["description"] as! String
        let forksNbr = dict["forks_count"] as! Int
        let language = dict["language"] as! String 
        let repoURL = dict["html_url"] as! String
        
        downloadImgFor(avatarUrl: avatarUrl) { (returnedIMG) in
            self.downloadContributionData(contributorsUrl: numberOfContributorsURL, completion: { (returnedContrNbr) in
                let repository = Repository(image: returnedIMG, name: name, description: descr, forks: forksNbr, language: language, contributors: returnedContrNbr, repoUrl: repoURL)
                completion(repository)
            })
        }
    }
    
    //MARK: IMAGE DOWNLOADING METHOD
    func downloadImgFor(avatarUrl : String, completion: @escaping (_ image : UIImage) -> ()) {
        Alamofire.request(avatarUrl).responseImage { (imageResponse) in
            guard let image = imageResponse.result.value else {return}
            completion(image)
        }
    }
    
    //MARK: CONTRIBUTORS AMOUNT METHOD
    func downloadContributionData(contributorsUrl : String, completion : @escaping (_ contributors : Int) -> ()) {
        Alamofire.request(contributorsUrl).responseJSON { (response) in
            guard let json = response.result.value as? [Dictionary<String , Any>] else {return}
            if !json.isEmpty {
                let contributions = json.count
                completion(contributions)
            }
        }
    }
}
