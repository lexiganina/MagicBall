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
    
    private var answersDataResult: AnswersData?
    private var internetStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkMonitor.shared.delegate = self
    }
    
    //    MARK: - Data request
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
    
    //    MARK: - Gesture
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            updateModelWithData()
        }
    }
    
    //    MARK: - Ball Logic
    func getAnswerFromInternet() -> String {
        if let answer = answersDataResult?.magic.answer {
            print("internet answer")
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
                print("random answer")
                return randomAnswer
            } else {
                let alert = UIAlertController(title: "No answers are available", message: "Go to Settings and add some. Or try to connect to the internet.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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
        internetStatus = false
    }
    
    
}

