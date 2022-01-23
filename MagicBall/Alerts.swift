//
//  Alerts.swift
//  
//
//  Created by Alex Hanina on 1/23/22.
//

import Foundation
import UIKit

struct Alerts {
    static let titleForNoAnswersAvailable = "No answers are available"
    static let messageForNoAnswersAvailable = "Go to Settings and add some. Or try to connect to the internet."
    static let titleForNoInternet = "No internet connection"
    static let messageForNoInternet = "You will receive one of the preset answers. You can manage them in Settings."
    static let titleForButton = "Ok"
    
    static var noInternet: UIAlertController {
        let alert = UIAlertController(title: titleForNoInternet, message: messageForNoInternet, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: titleForButton, style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    static var noAnswersAvailable: UIAlertController {
        let alert = UIAlertController(title: titleForNoAnswersAvailable, message: messageForNoAnswersAvailable, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: titleForButton, style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}
