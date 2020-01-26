//
//  ViewController.swift
//  Gitter
//
//  Created by Nazar Petruk on 24/01/2020.
//  Copyright © 2020 Nazar Petruk. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TrandingVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Vars&Lets
    let refreshcontrol = UIRefreshControl()
    let disposeBag = DisposeBag()
    var dataSource = PublishSubject<[Repository]>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshcontrol
        refreshcontrol.tintColor = #colorLiteral(red: 0.4803189635, green: 0.04282506555, blue: 0.0762879774, alpha: 1)
        refreshcontrol.attributedTitle = NSAttributedString(string: "Geting some sweet data 🔥", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.4803189635, green: 0.04282506555, blue: 0.0762879774, alpha: 0.9030314701), NSAttributedStringKey.font : UIFont.init(name: "AmericanTypewriter-Bold", size: 16.0)!])
        refreshcontrol.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        //MARK: TableView Managed
        fetchData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "trendingRepoCell")) {(row, repository : Repository, cell : TrendingRepoCell) in
            cell.configCell(repo: repository)
        }.disposed(by: disposeBag)
    }
    
    @objc func fetchData() {
        DownloadService.instance.downloadTrendingRepositories { (trendingRepositoriesArray) in
            self.dataSource.onNext(trendingRepositoriesArray)
            self.refreshcontrol.endRefreshing()
        }
    }
}

