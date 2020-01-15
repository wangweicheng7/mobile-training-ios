//
//  CommentModel.swift
//  MiniWeibo
//
//  Created by Weicheng Wang on 2020/1/15.
//  Copyright © 2020 ThoughtWorks. All rights reserved.
//

import UIKit

struct CommentModel: Decodable {
    var wid: String = ""
    var created_at: String?
    var id: Int = 0
    var content: String?
    var user: UserModel?
}

struct CommentResponse: Decodable {
    var error_code: Int = 0
    var msg: String?
    var data: [CommentModel]?
}
