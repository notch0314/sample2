//
//  GetTimelineOperatoin.swift
//  oruka_user_register
//
//  Created by Ryosuke Inoue on 2019/07/13.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import Foundation

final class GetTimelineOperatoin: Operation {
    
    typealias Output = Post
    
    private let page: Int
    private let limit: Int
    
    init(page: Int,
         limit: Int) {
        self.page = page
        self.limit = limit
    }
    
    var request: Request {
        return APIRequest.getTimeline(page: page, limit: limit)
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<Post> {
        return Promise<Post>({ resolve, reject,status  in
            do {
                try dispatcher.execute(request: self.request).then({ response in
                    switch response {
                    case .json(let json):
                        let post = try JSONDecoder().decode(Post.self, from: json)
                        resolve(post)
                        break
                    case .error(let error):
                        if let e = error {
                            reject(e)
                        }
                        break
                    }
                }).catch(reject)
            } catch {
                reject(error)
            }
        })
    }
}
