//
//  Request.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 7/26/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//


import Foundation


protocol Request {
    func getURLRequest(url: String) -> URLRequest?
}

enum RequestType: Request {
    
    init(type: RequestType) {
        self = type
    }
    
    func getURLRequest(url: String) -> URLRequest? {
        if let url = URL(string: url) {
            return URLRequest(url: url)
        }
        return nil
    }
}
