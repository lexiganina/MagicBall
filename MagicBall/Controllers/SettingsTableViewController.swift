//
//  SettingsTableViewController.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/23/22.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var addTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
 
        self.addTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func addButton(_ sender: Any) {
  
        let arrayFromUserDefaults = (UserDefaults.standard.array(forKey: RandomAnswers.randomAnswersArray)) as? [String]
        var array = arrayFromUserDefaults ?? [""]
        
        if let newAnswer = addTextField.text {
            if newAnswer != "" {
                array.append(newAnswer)
                addTextField.text?.removeAll()
            }
        }
        
        UserDefaults.standard.set(array, forKey: RandomAnswers.randomAnswersArray)
        
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayFromUserDefaults = UserDefaults.standard.array(forKey: RandomAnswers.randomAnswersArray)
        
        if let numberOfRows = arrayFromUserDefaults?.count {
            return numberOfRows
        }
        else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell()
        }
        
        let arrayFromUserDefaults = (UserDefaults.standard.array(forKey: RandomAnswers.randomAnswersArray)) as? [String]
        let array = arrayFromUserDefaults ?? [""]
        
        cell.setCellLable(text: array[indexPath.row])
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let arrayFromUserDefaults = (UserDefaults.standard.array(forKey: RandomAnswers.randomAnswersArray)) as? [String]
            var array = arrayFromUserDefaults ?? [""]
            array.remove(at: indexPath.row)
            UserDefaults.standard.set(array, forKey: RandomAnswers.randomAnswersArray)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

