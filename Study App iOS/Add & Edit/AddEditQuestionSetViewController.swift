//
//  AddEditQuestionSetViewController.swift
//  Study App iOS
//
//  Created by Matthew Riley on 12/5/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit

class AddEditQuestionSetViewController: UIViewController {
    
    @IBOutlet weak var questionSetTitleTextField: UITextField!
    @IBOutlet weak var questionSetDetailsTextField: UITextField!
    @IBOutlet weak var setTypeSegmentedControl: UISegmentedControl!
    
    
    var questionSetToEdit: QuestionSet!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionSetTitleTextField.text = questionSetToEdit.title
        questionSetDetailsTextField.text = questionSetToEdit.details //Make new to make a correction here as details is an optional
        
        switch questionSetToEdit.style {
        case .MultipleChoice:
            setTypeSegmentedControl.selectedSegmentIndex = 0
        case .FlashCard:
            setTypeSegmentedControl.selectedSegmentIndex = 1
        case .Blank:
            setTypeSegmentedControl.selectedSegmentIndex = 2
        default:
            setTypeSegmentedControl.selectedSegmentIndex = 0
        }


        // Do any additional setup after loading the view.
    }
    
    
    // touch screen to make keyboard go away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let title = questionSetTitleTextField.text, !title.isEmpty,
            let details = questionSetDetailsTextField.text, !details.isEmpty else {
                //Put an error alert function here
                return
        }
        
        var style: QuestionSet.Style
        
        switch setTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            style = .MultipleChoice
        case 1:
            style = .FlashCard
        case 2:
            style = .Blank
        default:
            style = .MultipleChoice
        }

        
//        questionSetToEdit = QuestionSet(Title: title, Details: details, Style: style)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


