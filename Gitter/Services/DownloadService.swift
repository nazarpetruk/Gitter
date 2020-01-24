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
                if reposArray.count <= 10 {
                    reposArray.append(repoDict)
                }else{
                    break
                }
            }
            completion(reposArray)
        }
    }
}
