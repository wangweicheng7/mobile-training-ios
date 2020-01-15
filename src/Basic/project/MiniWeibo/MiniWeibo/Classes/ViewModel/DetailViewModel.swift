//
//  DetailViewModel.swift
//  MiniWeibo
//
//  Created by Weicheng Wang on 2020/1/15.
//  Copyright © 2020 ThoughtWorks. All rights reserved.
//

import UIKit

class DetailViewModel {

    var service: HttpRequest
    
    // Outputs
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateWeibo:((WeiboModel) -> Void)?
    var didUpdateComments:(([CommentModel]) -> Void)?
    
    init(_ service: HttpRequest = HttpRequest(), weiboModel: WeiboModel) {
        self.service = service
        self.weiboModel = weiboModel
    }
    
    // TODO: Q&A 此处为什么要初始化，不初始化会如何
    private(set) var weiboModel: WeiboModel = WeiboModel() {
        didSet {
            didUpdateWeibo?(weiboModel)
        }
    }
    
    private(set) var dataSource: [CommentModel] = [CommentModel]() {
        didSet {
            didUpdateComments?(dataSource)
        }
    }
    
    // Inputs
    func refreshWeibo() {
        didUpdateWeibo?(weiboModel)
    }
    
    func refreshComments() {
        isRefreshing?(true)
        service.request(with: "http://localhost:3000/comments") { [weak self] data in
            guard let `self` = self else { return }
            self.finishRequest(with: data)
        }
    }
    
    // request finished
    private func finishRequest(with data: Data) {
        isRefreshing?(false)
        do {
            let decoder = JSONDecoder()
            let res = try decoder.decode(CommentResponse.self, from: data)
            guard let models = res.data else { return }
            self.dataSource = models
        }catch let e {
            print(e.localizedDescription)
        }
    }
}
