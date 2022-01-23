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
        var array = getRandomArrayFromUserDafaults()
        
        if let newAnswer = addTextField.text {
            if newAnswer != "" {
                array.append(newAnswer)
                addTextField.text?.removeAll()
            }
        }
        
        UserDefaults.standard.set(array, forKey: RandomAnswers.randomAnswersArray)
        tableView.reloadData()
    }
    
    // MARK: - Text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = getRandomArrayFromUserDafaults()
        let numberOfRows = array.count
        
        return numberOfRows
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell()
        }
        
        let array = getRandomArrayFromUserDafaults()
        cell.setCellLable(text: array[indexPath.row])
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var array = getRandomArrayFromUserDafaults()
            array.remove(at: indexPath.row)
            UserDefaults.standard.set(array, forKey: RandomAnswers.randomAnswersArray)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    private func getRandomArrayFromUserDafaults() -> [String] {
        if let arrayFromUserDefaults = (UserDefaults.standard.array(forKey: RandomAnswers.randomAnswersArray)) as? [String] {
            return arrayFromUserDefaults
        } else {
            return [""]
        }
    }
    
}

