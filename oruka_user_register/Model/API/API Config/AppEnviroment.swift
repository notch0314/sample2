//
//  FancyEnviroment.swift
//  fancy_ios
//
//  Created by 千葉大志 on 2019/01/11.
//  Copyright © 2019年 diverfront. All rights reserved.
//

import Foundation

final class AppEnviroment {
    
    static func appEnviroment() ->Environment {
        var em: Environment!
        #if DEBUG
        em = Environment("app_debug", host: "https://chibastusio-test-01.herokuapp.com/api/")
        #else
        em = Environment("app_production", host: "https://chibastusio-test-01.herokuapp.com/api/")
        #endif
        em.headers = [
        "Accept":"application/json",
        "Content-Type": "application/json"
        ]
        return em
    }
    
}
