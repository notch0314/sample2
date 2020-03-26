//
//  Response.swift
//  fancy_ios
//
//  Created by 千葉大志 on 2019/01/10.
//  Copyright © 2019年 diverfront. All rights reserved.
//

import Foundation

public enum Response {
    case json(_: Data)
    case error(_: APIError?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        guard response.r?.statusCode == 200, response.error == nil else {
            if let data = response.data {
                let url = response.r?.url?.absoluteString ?? ""
                let log = (String(data: data, encoding: String.Encoding.utf8) ?? "") + url
                debugPrint(log)
                let apiError = APIError(response.r!.statusCode)
                self = .error(apiError)
            } else {
                self = .error(APIError.unexpectedError)
            }
            return
        }
        
        guard let data = response.data else {
            self = .error(APIError.unexpectedError)
            return
        }
        
        let url = response.r?.url?.absoluteString ?? ""
        let log = (String(data: data, encoding: String.Encoding.utf8) ?? "") + url
        debugPrint(log)
        
        switch request.dataType {
        case .JSON:
            self = .json(data)
        }
    }
}
