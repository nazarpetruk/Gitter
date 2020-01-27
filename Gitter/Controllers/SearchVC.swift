//
//  SearchVC.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    
    //MARK: IBOutlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTxtField: FancyTextField!
    
    //MARK: Variables
    var disposeBag = DisposeBag()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        searchTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    func bindElements() {
        let searchResultObservable = searchTxtField.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map{
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        }
        .flatMap { (query) -> Observable<[Repository]> in
            if query == "" {
                return Observable<[Repository]>.just([])
            }else{
                let url = searchURL + query + starsDescending
                var searchedRepositories = [Repository]()
                return URLSession.shared.rx.json(url: URL(string: url)!)
                    .map {
                        let results = $0 as AnyObject
                        let items = results.object(forKey: "items") as? [Dictionary<String, Any>] ?? []
                        for item in items {
                            guard let name = item["name"] as? String,
                                let description = item["description"] as? String,
                                let forksCount = item["forks_count"] as? Int,
                                let language = item["language"] as? String,
                                let repositoryURL = item["html_url"] as? String else {break}
                            
                            let repository = Repository(image: UIImage(named: "searchIconLarge")!, name: name, description: description, forks: forksCount, language: language, contributors: 0, repoUrl: repositoryURL)
                            searchedRepositories.append(repository)
                        }
                        return searchedRepositories
                }
            }
        }
        .observeOn(MainScheduler.instance)
        searchResultObservable.bind(to: searchTableView.rx.items(cellIdentifier: "searchResultCell")){
            (row, repository : Repository, cell : SearchResultCell) in
            cell.configureCell(repository: repository)
        }
    .disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchResultCell else {return}
        //cell.backgroundColor = #colorLiteral(red: 0.450481832, green: 0.3242934644, blue: 0.597058773, alpha: 0.9030314701)
        let url = cell.repoUrl!
        self.presentSafariVCFor(url: url)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
