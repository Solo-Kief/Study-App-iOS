//  AddEditQuestionSetViewController.swift
//  Study App iOS
//
//  Created by Solomon Kieffer on 12/13/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class AddEditQuestionSetViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var QSTypeLabel: UILabel!
    @IBOutlet var questionSetTitleField: UITextField!
    @IBOutlet var questionSetDescriptionField: UITextView!
    @IBOutlet var questionSetTypeSelector: UISegmentedControl!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    var didCreateQuestionSet: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Colors and Semantics
        questionSetTypeSelector.layer.cornerRadius = 20.0
        questionSetTypeSelector.layer.borderColor = StorageEnclave.Access.getCurrentSecondaryColor().cgColor
        questionSetTypeSelector.layer.borderWidth = 1.0
        questionSetTypeSelector.layer.masksToBounds = true
        
        view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        cancelButton.tintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        titleLabel.textColor = StorageEnclave.Access.getCurrentTextColor()
        questionSetTitleField.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        questionSetTitleField.textColor = StorageEnclave.Access.getCurrentTextColor()
        questionSetDescriptionField.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        questionSetDescriptionField.textColor = StorageEnclave.Access.getCurrentTextColor()
        QSTypeLabel.textColor = StorageEnclave.Access.getCurrentTextColor()
        questionSetTypeSelector.tintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        submitButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        submitButton.tintColor = StorageEnclave.Access.getCurrentTextColor()
        //////////////////////
        didCreateQuestionSet!(false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func addQuestionSet(_ sender: Any) {
        guard questionSetTitleField.text != "" && questionSetTypeSelector.selectedSegmentIndex != -1 else {
            let alert = UIAlertController(title: "Incomplete", message: "A title must be made and a type selected in order to create a new question set", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            return present(alert, animated: true, completion: nil)
        }
        
        let newSet = QuestionSet(Title: questionSetTitleField.text!, Style: QuestionSet.Style(rawValue: questionSetTypeSelector.selectedSegmentIndex)!)
        if questionSetDescriptionField.text != "" {
            newSet.details = questionSetDescriptionField.text!
        }
        
        StorageEnclave.Access.addQuestionSet(newSet)
        
        let alert = UIAlertController(title: "Complete", message: "You're new question set had been created.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Great!", style: .default) { (_) in
            self.didCreateQuestionSet!(true)
            self.returnToPrevious(self.submitButton)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func returnToPrevious(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
