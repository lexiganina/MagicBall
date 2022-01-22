//
//  URLBuilder.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/22/22.
//

import Foundation


final class URLBuilder {
    
    private var urlString = ""
    
    func base() {
        urlString += "https://8ball.delegator.com/"
    }
    
    func magic() {
        urlString += "magic/"
    }
    
    func JSON() {
        urlString += "JSON/"
    }
    
    func questionString(question: String) {
        urlString += "\(question)"
    }
    
    func build() -> String {
        return urlString
    }
}
