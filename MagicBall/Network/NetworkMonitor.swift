//
//  NetworkMonitor.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/22/22.
//

import Foundation
import Reachability

protocol NetworlMonitorDelegate {
    func didConnected()
    func didDisconected()
}

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private init() {}
    
    var delegate: NetworlMonitorDelegate?
    let reachability = try! Reachability()
    
    func startNWListner() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                self.delegate?.didConnected()
            } else {
                print("Reachable via Cellular")
                self.delegate?.didConnected()
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.delegate?.didDisconected()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .unavailable:
            print("Network not reachable")
        case .none:
            print("Network none")
        }
    }
    
    
}
