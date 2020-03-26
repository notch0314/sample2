//
//  FancyDispatcher.swift
//  fancy_ios
//
//  Created by 千葉大志 on 2019/01/11.
//  Copyright © 2019年 diverfront. All rights reserved.
//

import Foundation

final class AppDispatcher {
    
    static func appDispatcher() ->Dispatcher {
        let dispatcher = NetworkDispatcher(environment: AppEnviroment.appEnviroment())
        return dispatcher
    }
    
}
