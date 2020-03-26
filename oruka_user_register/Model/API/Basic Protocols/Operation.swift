//
//  Operation.swift
//  fancy_ios
//
//  Created by 千葉大志 on 2019/01/10.
//  Copyright © 2019年 diverfront. All rights reserved.
//

import Foundation

protocol Operation {
    associatedtype Output
    
    /// Request to execute
    var request: Request { get }
    
    
    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    /// - Returns: a promise
    func execute(in dispatcher: Dispatcher) -> Promise<Output>
    
}
