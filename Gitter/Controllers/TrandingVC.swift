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
        DownloadService.instance.dawnloadRepositories { (reposArray) in
            print(reposArray[1].name)
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
        let repository = Repository(name: "RxSwift", image: UIImage(named: "searchIconLarge")!, descript: "Reactive programming library", forks: 2392, language: "Swift", contributors: 2386, repoUrl: "www.google.com")
        cell.configCell(repo: repository)
        return cell
    }
}

