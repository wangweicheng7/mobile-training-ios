//
//  DetailHeaderView.swift
//  MiniWeibo
//
//  Created by Weicheng Wang on 2020/1/15.
//  Copyright © 2020 ThoughtWorks. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var singleImageView: UIImageView!
    @IBOutlet var coverImageViews: [UIImageView]!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var coverImageHeightConstraint: NSLayoutConstraint!
    
    class func loadView() ->  DetailHeaderView? {
        
        guard let view = UINib(nibName: "DetailHeaderView", bundle: nil).instantiate(withOwner: self, options: nil).last as? DetailHeaderView else {
            return nil
        }

        return view
    }
    
    func set(_ model: WeiboModel) {
        nicknameLabel.text = model.user?.nickname
        descLabel.text = "\(model.follow_count)人关注了TA"
        levelImageView.isHidden = true
        followButton.isEnabled = true
        flagImageView.isHidden = !model.is_vip
        if let avatar = model.user?.avatar {
            let url = URL(string: "http://localhost:3000/" + avatar)!
            avatarImageView.load(from: url)
        }else{
            avatarImageView.backgroundColor = UIColor.gray
        }
        
        
        singleImageView.isHidden = true
        coverImageViews.forEach{ $0.isHidden = true }
        
        contentLabel.text = model.content
        
        guard let count = model.imgs?.count, count > 0 else {
            coverImageHeightConstraint.constant = 0
            return
        }
        
        for (idx, value) in (model.imgs ?? []).enumerated() {
            let imageView: UIImageView
            if count == 1 {
                imageView = singleImageView
            }else if count == 4 && idx > 1 {
                imageView = coverImageViews[idx+1]
            }else{
                imageView = coverImageViews[idx]
            }
            
            imageView.isHidden = false
            let url = URL(string: "http://localhost:3000/" + value)!
            imageView.load(from: url)
            
        }
        // 图片高度
        let height = (UIScreen.main.bounds.width - 30 - 20)/3
        
        if count == 1 {
            coverImageHeightConstraint.constant = 3 * (height + 10)
        }else if count <= 3 {
            coverImageHeightConstraint.constant = height + 10
        }else if count <= 6 {
            coverImageHeightConstraint.constant = 2 * (height + 10)
        }else if count <= 9 {
            coverImageHeightConstraint.constant = 3 * (height + 10)
        }
    }

}
