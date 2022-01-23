//
//  ViewController.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/22/22.
//

import UIKit
import AudioToolbox
import Reachability

class BallViewController: UIViewController {

    @IBOutlet weak var answerLable: UILabel!
    @IBOutlet weak var ballImageView: UIImageView!
    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    
    private var answersDataResult: AnswersData?
    private var internetStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballImageView.dropShadow()
        NetworkMonitor.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            buttonTopConstraint.constant = 15
        } else {
            buttonTopConstraint.constant = 44
        }
    }
    
    // MARK: - Data request
    
    func updateModelWithData() {
        if internetStatus {
            NetworkManager.shared.downloadAnswersData { answersData in
                DispatchQueue.main.async {
                    self.answersDataResult = answersData
                    self.answerLable.text = self.getAnswerFromInternet()
                }
            } onError: { error in
                print(error)
                DispatchQueue.main.async {
                    self.answerLable.text = self.getRandomeAnswer()
                }
            }
        } else {
            self.answerLable.text = self.getRandomeAnswer()
        }
    }
    
    // MARK: - Gesture
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            updateModelWithData()
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    // MARK: - Ball Logic
    
    func getAnswerFromInternet() -> String {
        if let answer = answersDataResult?.magic.answer {
            print("Internet answer")
            return answer
        } else {
            print("Data decoding failed")
            return getRandomeAnswer()
        }
    }
    
    func getRandomeAnswer() -> String {
        let arrayFromUserDefaults = (UserDefaults.standard.array(forKey: RandomAnswers.randomAnswersArray)) as? [String]
        
        if let array = arrayFromUserDefaults {
            if array.count != 0 {
                let randomAnswer = array[Int.random(in: 0 ..< array.count)]
                print("Random answer")
                return randomAnswer
            } else {
                self.present(Alerts.noAnswersAvailable, animated: true, completion: nil)
            }
        }
        
        return "Shake your phone"
    }
}

extension BallViewController: NetworlMonitorDelegate {
    func didConnected() {
        internetStatus = true
    }
    
    func didDisconected() {
        self.present(Alerts.noInternet, animated: true, completion: nil)
        internetStatus = false
    }
    
}
