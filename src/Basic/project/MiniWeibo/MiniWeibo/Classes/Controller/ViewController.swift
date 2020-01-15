//
//  ViewController.swift
//  MiniWeibo
//
//  Created by Weicheng Wang on 2019/12/18.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ViewModel = ViewModel(HttpRequest())
    var dataSource: [WeiboModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set delegate,
        // Q&A: Why delegate and dataSource uses weak?
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeiboTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "WeiboTableViewCell")
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.didUpdateWeibo = { [weak self] data in
            self?.dataSource = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.isRefreshing = { refreshing in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = refreshing
            }
        }
        
        viewModel.didSelecteWeibo = { [weak self] model in
            DispatchQueue.main.async {
                let vm = DetailViewModel(HttpRequest(), weiboModel: model)
                let vc = DetailViewController()
                vc.viewModel = vm
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
        let group = DispatchGroup()
        
        let queue = DispatchQueue(label: "com.caifan.shabi")
        
        group.enter()
        queue.async { [weak self] in
            print("first enter")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                print("first leave")
                group.leave()
            }
            
        }
        
        group.enter()
        queue.async { [weak self] in
            print("second enter")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                print("second leave")
                group.leave()
            }
            
        }
        group.notify(queue: queue) {
            print("group exc")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshData()
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeiboTableViewCell", for: indexPath) as! WeiboTableViewCell
        let model = dataSource[indexPath.row]
        cell.set(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
