//
//  AddEditQuestionsViewController.swift
//  Study App iOS
//
//  Created by Matthew Riley on 12/5/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit

class AddEditQuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerOneTextField: UITextField!
    @IBOutlet weak var answerTwoTextField: UITextField!
    @IBOutlet weak var answerThreeTextField: UITextField!
    @IBOutlet weak var answerFourTextField: UITextField!
    @IBOutlet weak var correctAnswerSegmentController: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    
    
    
    
    var questionsArrayToEdit: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionLabel.text = "Question 1"
        questionTextField.text = questionsArrayToEdit[0].question
        answerOneTextField.text = questionsArrayToEdit[0].answers[0]
        answerTwoTextField.text = questionsArrayToEdit[0].answers[1]
        answerThreeTextField.text = questionsArrayToEdit[0].answers[2]
        answerFourTextField.text = questionsArrayToEdit[0].answers[3]
        
        switch questionsArrayToEdit[0].correctAnswer {
        case 0:
            correctAnswerSegmentController.selectedSegmentIndex = 0
        case 1:
            correctAnswerSegmentController.selectedSegmentIndex = 1
        case 2:
            correctAnswerSegmentController.selectedSegmentIndex = 2
        case 3:
            correctAnswerSegmentController.selectedSegmentIndex = 3
        default:
            correctAnswerSegmentController.selectedSegmentIndex = 0
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: "Error", message: "Please enter text in all fields, or hit the back button to go back to the quiz.", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Close", style: .default) { _ in
        }
        errorAlert.addAction(dismissAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    // touch screen to make keyboard go away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func submitButton(_ sender: Any) {
        // make sure each txt field has txt
        guard let question = questionTextField.text, !question.isEmpty,
            let answerOne = answerOneTextField.text, !answerOne.isEmpty,
            let answerTwo = answerTwoTextField.text, !answerTwo.isEmpty,
            let answerThree = answerThreeTextField.text, !answerThree.isEmpty,
            let answerFour = answerFourTextField.text, !answerFour.isEmpty else {
                showErrorAlert()
                return
        }
        
        self.performSegue(withIdentifier: "unwindToAddEditQuestionSetWIthSegue", sender: self)
    }
    
}




