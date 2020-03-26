//
//  Error.swift
//  fancy_ios
//
//  Created by 千葉大志 on 2019/01/14.
//  Copyright © 2019年 diverfront. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case badRequest
    case unexpectedError
    
    init(_ errorCode: Int) {
        if errorCode == 400 {
            self = .badRequest
        } else {
            self = .unexpectedError
        }
    }
}

struct ErrorMessage {
    
    let errorMessage: String
    
    init(error: Error) {
        if case APIError.badRequest = error {
            errorMessage = "不正なリクエストです"
        } else if case APIError.unexpectedError = error {
            errorMessage = "サーバーエラーです"
        } else {
            errorMessage = "サーバーエラーです"
        }
    }
}
