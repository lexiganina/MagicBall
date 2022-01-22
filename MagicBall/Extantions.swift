//
//  Extantions.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/22/22.
//

import Foundation

extension String {
    
    func encodeURIComponent() -> String? {
        let characterSet = NSMutableCharacterSet.urlQueryAllowed
        
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
    
}
