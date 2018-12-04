//
//  FillInTheBlankViewController.swift
//  Study App iOS
//
//  Created by Matthew Riley on 11/27/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit

class FillInTheBlankViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var dummyFillInTheBlankQuestionSet: QuestionSet!
    
    //Current fill in the blank question being answered
    var currentFillInTheBlankQuestion: Question! {
        didSet {
            //Whenever a new currentFillInTheBlankQuestion is set, update the UI for that new question
            questionTextView.text = currentFillInTheBlankQuestion.question
        }
    }
    
    //Array that holds the questions that have been answered
    var completedFillInTheBlankQuestions: [Question] = []
    
    //Stores the index of the currentFillInTheBlankQuestion
    var randomIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateFillInTheBlankQuestions()
        getNewFillInTheBlankQuestion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.submitButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.submitButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.questionTextView.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        self.questionTextView.textColor = StorageEnclave.Access.getCurrentTextColor()
        answerTextField.layer.cornerRadius = 15
        answerTextField.layer.masksToBounds = true
    }
    
    
    //Popultates questions when the screen loads
    func populateFillInTheBlankQuestions() {
        //A Fill in the blank QuestionSet
        let question1 = Question(Question: "In a deck of cards the king of ______ is the only king without a moustache.", Answers: ["Hearts"], CorrectAnswer: 0)
        let question2 = Question(Question: "Stressed is ______ spelled backwards.", Answers: ["Desserts"], CorrectAnswer: 0)
        let question3 = Question(Question: "The Twitter bird's actual name is ______.", Answers: ["Larry"], CorrectAnswer: 0)
        dummyFillInTheBlankQuestionSet = QuestionSet(Title: "Dummy Fill In The Blank Questions", Details: nil, Questions: [question1, question2, question3], Style: .Blank)
    }
    
    //Gets a random question from the array of fill in the blank questions
    func getNewFillInTheBlankQuestion() {
        if dummyFillInTheBlankQuestionSet.questions.count > 0 {
            //Get a random index from 0 to 1 less then the amount of elements in the questions array
            randomIndex = Int.random(in: 0..<dummyFillInTheBlankQuestionSet.questions.count)
            //Set currentQuestion equal to the question that is at the random index in the questions array
            currentFillInTheBlankQuestion = dummyFillInTheBlankQuestionSet.questions[randomIndex]
        } else {
            dummyFillInTheBlankQuestionSet.questions = self.completedFillInTheBlankQuestions
            completedFillInTheBlankQuestions.removeAll()
            //Get a new question
            getNewFillInTheBlankQuestion()
        }
    }
    
    //Shows an alert when the user gets the question correct
    func showCorrectAnswerAlert() {
        //UIAlertController
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentFillInTheBlankQuestion.answers[0]) was the correct answer.", preferredStyle: .actionSheet)
        //UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.completedFillInTheBlankQuestions.append(self.dummyFillInTheBlankQuestionSet.questions.remove(at: self.randomIndex))
            self.getNewFillInTheBlankQuestion()
        }
        //Add action to the alert controller
        correctAlert.addAction(closeAction)
        //Present the alert controller
        self.present(correctAlert, animated: true, completion: nil)
    }

    //Shows an alert when the user get the question wrong
    func showIncorrectAnswerAlert() {
        //UIAlertController
        let incorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentFillInTheBlankQuestion.answers[0]) was the correct answer.", preferredStyle: .actionSheet)
        //UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.completedFillInTheBlankQuestions.append(self.dummyFillInTheBlankQuestionSet.questions.remove(at: self.randomIndex))
            self.getNewFillInTheBlankQuestion()
        }
        //Add the action to the alert controller
        incorrectAlert.addAction(closeAction)
        //Present the alert controller
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if answerTextField.text! == "" {
            answerTextField.placeholder = "Please enter an answer"
            return
        } else if answerTextField.text!.lowercased() == currentFillInTheBlankQuestion.answers[0].lowercased() {
            showCorrectAnswerAlert()
            answerTextField.text! = ""
            answerTextField.placeholder = ""
        } else {
            showIncorrectAnswerAlert()
            answerTextField.text! = ""
            answerTextField.placeholder = ""
        }
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

/*
 
 IDEAS FOR FILL IN THE BLANK PAGE
 1. Fix placeholder stuff (Ex: Changing placeholder text to disapper when beginning to edit text in answerTextField)
 2. Change questionLabel.text make it show Correct or not correct with a sleep timer and then showing the next question? (Instead of having the pop up alert action thing)
 3. Set up a reset button?
 4. Set up a score keeper?
 5. Change questionTextView to a LABEL
 
 */

