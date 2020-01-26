//
//  ViewController.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit

class TrandingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        DownloadService.instance.downloadTrendingRepos { (repos) in
            print(repos[0].name)
            print(repos[1].name)
            print(repos[2].name)
            print(repos[3].name)
            print(repos[4].name)
            print(repos[5].name)
            print(repos[6].name)
        }
    }
    
    //MARK: TableViewProtocol methods
    
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell", for: indexPath) as? TrendingRepoCell else { return UITableViewCell() }
        let repository = Repository(image: UIImage(named: "searchIconLarge")!, name: "RxSwift", description: "Reactive programming library", forks: 2392, language: "Swift", contributors: 2386, repoUrl: "www.google.com")
        cell.configCell(repo: repository)
        return cell
    }
}

