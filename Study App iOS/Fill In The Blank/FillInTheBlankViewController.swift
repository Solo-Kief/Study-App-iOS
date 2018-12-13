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
    @IBOutlet weak var questionTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet var changeQuestionsButton: UIButton!
    
    var questionSetStyle = QuestionSet.Style.Blank
    var liveQuestionSet: QuestionSet?
    var lastQuestion = -1
    var defaultColor = StorageEnclave.Access.getCurrentSecondaryColor()
    
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
        
        if StorageEnclave.Access.getDefault(for: QuestionSet.Style.Blank) == nil {
            questionTextView.text = "There are no questions currently loaded."
            liveQuestionSet = nil
        } else {
            liveQuestionSet =
                StorageEnclave.Access.getQuestionSet(at: StorageEnclave.Access.getDefault(for: QuestionSet.Style.Blank)!)
        }
        
        getNewFillInTheBlankQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        submitButton.isHidden = false
        changeQuestionsButton.tintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.submitButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.submitButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.questionTextView.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        self.questionTextView.textColor = StorageEnclave.Access.getCurrentTextColor()
        answerTextField.layer.cornerRadius = 15
        answerTextField.layer.masksToBounds = true
        
        if StorageEnclave.Access.getQuestionSetCount() == 0 {
            liveQuestionSet = nil
            viewDidLoad()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionSetCollectionViewController {
            destination.selectedStyle = .Blank
            destination.newQuestionSet = { newQuestionSet in
                self.liveQuestionSet = newQuestionSet
                self.getNewFillInTheBlankQuestion()
            }
        }
    }
    
    //Popultates questions when the screen loads
    func populateFillInTheBlankQuestions() -> QuestionSet {
        //A Fill in the blank QuestionSet
        let question1 = Question(Question: "In a deck of cards the king of ______ is the only king without a moustache.", Answers: ["Hearts"], CorrectAnswer: 0)
        let question2 = Question(Question: "Stressed is ______ spelled backwards.", Answers: ["Desserts"], CorrectAnswer: 0)
        let question3 = Question(Question: "What is the Twitter bird's actual name?", Answers: ["Larry"], CorrectAnswer: 0)
        return(QuestionSet(Title: "Dummy Fill In The Blank Questions", Details: nil, Questions: [question1, question2, question3], Style: .Blank))
    }
    
    //Gets a random question from the array of fill in the blank questions
    func getNewFillInTheBlankQuestion() {
        guard liveQuestionSet != nil else {
            return
        }
        
        if let liveQuestionSet = liveQuestionSet {
            if liveQuestionSet.questions.count > 0 {
                //Get a random index from 0 to 1 less then the amount of elements in the questions array
                randomIndex = Int.random(in: 0..<liveQuestionSet.questions.count)
                //Set currentQuestion equal to the question that is at the random index in the questions array
                currentFillInTheBlankQuestion = liveQuestionSet.questions[randomIndex]
            } else {
                liveQuestionSet.questions = self.completedFillInTheBlankQuestions
                completedFillInTheBlankQuestions.removeAll()
                //Get a new question
                getNewFillInTheBlankQuestion()
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.questionTextView.backgroundColor = UIColor.clear
                self.questionTextView.textColor = UIColor.clear
            })
            let time = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTextViewConstraint), userInfo: nil, repeats: false)
            time.fireDate = Date().addingTimeInterval(0.35)
        } else {
            submitButton.isHidden = true
        }
    }
    
    //Shows an alert when the user gets the question correct
    func showCorrectAnswerAlert() {
        //UIAlertController
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentFillInTheBlankQuestion.answers[0]) was the correct answer.", preferredStyle: .actionSheet)
        //UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.completedFillInTheBlankQuestions.append(self.liveQuestionSet!.questions.remove(at: self.randomIndex))
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
            self.completedFillInTheBlankQuestions.append(self.liveQuestionSet!.questions.remove(at: self.randomIndex))
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
        
        let time = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(resetScenario), userInfo: nil, repeats: false)
        time.fireDate = Date().addingTimeInterval(1.25)
    }
    
    @IBAction func tappedInsideAnswerTextField(_ sender: Any) {
        answerTextField.placeholder = ""
    }
    
    @objc func updateTextViewConstraint() { //View did load helper.
        questionTextViewHeight.constant = CGFloat(20 * Double(Double(self.questionTextView.text.count) / 50).rounded(.up) + 10)
        if questionTextViewHeight.constant == 30 {
            questionTextView.layer.cornerRadius = 15
        } else {
            questionTextView.layer.cornerRadius = 20
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.questionTextView.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
            self.questionTextView.textColor = StorageEnclave.Access.getCurrentTextColor()
        })
    }
    
    @objc func resetScenario() {
        UIView.animate(withDuration: 0.25, animations: {self.submitButton.backgroundColor = self.defaultColor})
        submitButton.isUserInteractionEnabled = true
        getNewFillInTheBlankQuestion()
    }
    
    @IBAction func questionSetsButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "showQuestionSetsScreen", sender: self)
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
 -Change questionLabel.text make it show Correct or not correct with a sleep timer and then showing the next question? (Instead of having the pop up alert action thing)
 -Set up a reset button?
 -Set up a score keeper?
 
 
 */

