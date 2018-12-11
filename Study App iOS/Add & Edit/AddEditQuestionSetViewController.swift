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
    
    var newQuestionSet: ((QuestionSet) -> Void)?
    
    var questionsArrayToEdit: [Question] = []
    
    var questionSetToEdit: QuestionSet!
    
    var style = QuestionSet.Style.Blank
    
    var tempQuestionsArray: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        questionSetTitleTextField.text = questionSetToEdit.title
//        questionSetDetailsTextField.text = questionSetToEdit.details //Make new to make a correction here as details is an optional
//
//        switch questionSetToEdit.style {
//        case .MultipleChoice:
//            setTypeSegmentedControl.selectedSegmentIndex = 0
//        case .FlashCard:
//            setTypeSegmentedControl.selectedSegmentIndex = 1
//        case .Blank:
//            setTypeSegmentedControl.selectedSegmentIndex = 2
//        }
//
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddEditQuestionsViewController {
            //We need to pass through the Game that we'll be editing.
            destination.questionsArrayToEdit = tempQuestionsArray
        }
    }
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: "Error", message: "Please enter text in all fields, or hit the back button to go back to the quiz.", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    
    
    // touch screen to make keyboard go away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "showQuestionsScreen", sender: self)
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let title = questionSetTitleTextField.text, !title.isEmpty,
            let details = questionSetDetailsTextField.text, !details.isEmpty else {
                //Put an error alert function here
                return
        }
        
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
        
        questionSetToEdit = QuestionSet(Title: title, Details: details, Questions: questionsArrayToEdit, Style: style)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func unwindToAddEditQuestionSet(segue: UIStoryboardSegue) {}
}


