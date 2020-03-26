//
//  APIRequest.swift
//  fancy_ios
//
//  Created by 千葉大志 on 2019/01/10.
//  Copyright © 2019年 diverfront. All rights reserved.
//


enum APIRequest: Request {
    
    case signUp(name: String, gender: Int, area: String, age: String, bio: String?)
    case getTimeline(page: Int, limit:Int)
    
    public var path: String {
        switch self {
        case .signUp:
            return "v1/sign_up"
        case .getTimeline:
            return "v1/timeline"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        case .getTimeline:
            return .get
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .signUp(let name, let gender, let area, let age, let bio):
            var params = [String: Any]()
            var userAttributes = [String: Any]()
            userAttributes["name"] = name
            userAttributes["gender"] = gender
            userAttributes["area"] = area
            userAttributes["age"] = age
            userAttributes["bio"] = bio
            params["user"] = userAttributes
            return .body(params)
        case .getTimeline(let page, let limit):
            var params = [String: Any]()
            params["page"] = page
            params["limit"] = limit
            return .url(params)
        }
    }
    
    public var headers: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .signUp, .getTimeline:
            return .JSON
        }
    }
}
