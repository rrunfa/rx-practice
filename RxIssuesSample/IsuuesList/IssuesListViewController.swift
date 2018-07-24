//
//  IssuesListViewController.swift
//  RxPractice
//
//  Created by Nikita Nagaynik on 23/07/2018.
//  Copyright © 2018 Nikita Nagaynik. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift
import RxCocoa
import Swinject

class IssuesListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var provider: MoyaProvider<GitHub>!
    var latestRepositoryName: Observable<String> {
        let text = searchBar.rx.text
        return text.orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    var issueTrackerModel: IssueTrackerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        provider = MoyaProvider<GitHub>(plugins: [NetworkLoggerPlugin()])
    
        
        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
        
        issueTrackerModel
            .trackIssues()
            .bind(to: tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "IssuesCellId", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.title
                
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                if self.searchBar.isFirstResponder {
                    self.view.endEditing(true)
                }
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
