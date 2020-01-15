//
//  DetailViewController.swift
//  MiniWeibo
//
//  Created by Weicheng Wang on 2020/1/15.
//  Copyright © 2020 ThoughtWorks. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DetailViewModel?
    var dataSource: [CommentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.reloadData()
//        tableHeaderView?.layoutIfNeeded()
//
//        tableView.tableHeaderView = tableHeaderView
        
        setupViewModel()
    }
    
    private func setupViewModel() {
        
        viewModel?.didUpdateComments = { [weak self] data in
            self?.dataSource = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.didUpdateWeibo = { [weak self] data in
            DispatchQueue.main.async {
                self?.tableHeaderView?.set(data)
                self?.tableHeaderView?.layoutIfNeeded()
                self?.tableView.tableHeaderView = self?.tableHeaderView
            }
        }
        
        viewModel?.isRefreshing = { refreshing in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = refreshing
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.refreshWeibo()
        viewModel?.refreshComments()
    }
    
    lazy var tableHeaderView: DetailHeaderView? = {
        let view = DetailHeaderView.loadView()
        return view
    }()

}
