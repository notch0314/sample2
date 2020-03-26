//
//  Dispatcher.swift
//  fancy_ios
//
//  Created by 千葉大志 on 2019/01/10.
//  Copyright © 2019年 diverfront. All rights reserved.
//

import Foundation

/// The dispatcher is responsible to execute a Request
/// by calling the underlyning layer (maybe URLSession, Alamofire
/// or just a fake dispatcher which return mocked results).
/// As output for a Request it should provide a Response.
public protocol Dispatcher {
    
    /// Configure the dispatcher with an environment
    ///
    /// - Parameter environment: environment configuration
    init(environment: Environment)
    
    
    
    /// This function execute the request and provide a Promise
    /// with the response.
    ///
    /// - Parameter request: request to execute
    /// - Returns: promise
    func execute(request: Request) throws -> Promise<Response>
    
}
