//  ViewController.swift
//  Trivia Game
//
//  Created by Jake Dillon on 11/26/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class multipleChoiceViewController: UIViewController {
    @IBOutlet var questionField: UITextView!
    @IBOutlet var questionFieldHeight: NSLayoutConstraint!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!
    
    var questions: QuestionSet = QuestionSet(Title: "Temp", Style: .MultipleChoice)
    var correctAnswer = 0
    var defaultColor = UIColor()
    var lastQuestion = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidAppear(false)
        
        defaultColor = answer1.backgroundColor!
        
        questions = buildDefaultQuestions()

        loadQuestion()
        self.navigationItem.title = "Multiple Choice";
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.answer1.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.answer2.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.answer3.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.answer4.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.answer1.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.answer2.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.answer3.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.answer4.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.questionField.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        self.questionField.textColor = StorageEnclave.Access.getCurrentTextColor()
    }
    
    func buildDefaultQuestions() -> QuestionSet {
        let question1 = Question(Question: "What is Dr Suess's real name?", Answers: ["Andrew Butterson", "Suess Stephenson", "Micheal Gene Scott", "Theodor Seuss Geisel"], CorrectAnswer: 3)
        let question2 = Question(Question: "What year did heavy metal legend Lemmy Kilmister die?", Answers: ["1997", "2012", "2015", "2008"], CorrectAnswer: 2)
        let question3 = Question(Question: "In Norse Mythology who is the god of light, joy, purity, beauty, innocence, and reconciliation?", Answers: ["Odin", "Balder", "Frigg", "Tyr"], CorrectAnswer: 1)
        let question4 = Question(Question: "Famous gothic author Edgar Allen Poe wrote which short story?", Answers: ["Call of Cathulu", "Reign in Blood", "Tomorrow is Today", "Tell Tale Heart"], CorrectAnswer: 3)
        let question5 = Question(Question: "Which is a real law in the state of Oklahoma?", Answers: ["No bear wrestling", "No eating rice past 9:00 p.m.", "Can't wear red shoes in the month of January", "It is illegal to practice Vodoo"], CorrectAnswer: 0)
        
        let questionSet = QuestionSet(Title: "Default Questions", Details: nil, Questions: [question1, question2, question3, question4, question5], Style: .MultipleChoice)
        
        return questionSet
    }

    func loadQuestion() {
        var selector = Int.random(in: 0..<questions.questions.count)
        while lastQuestion == selector && questions.questions.count != 1 {
            selector = Int.random(in: 0..<questions.questions.count)
        } //Prevents a question from repeating back-to-back.
        lastQuestion = selector
        
        questionField.text = questions.questions[selector].question
        answer1.setTitle(questions.questions[selector].answers[0], for: .normal)
        answer2.setTitle(questions.questions[selector].answers[1], for: .normal)
        answer3.setTitle(questions.questions[selector].answers[2], for: .normal)
        answer4.setTitle(questions.questions[selector].answers[3], for: .normal)
        correctAnswer = questions.questions[selector].correctAnswer
        
        UIView.animate(withDuration: 0.25, animations: {
            self.questionField.backgroundColor = UIColor.clear
            self.questionField.textColor = UIColor.clear
        })
        let time = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTextViewConstraint), userInfo: nil, repeats: false)
        time.fireDate = Date().addingTimeInterval(0.35)
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        answer1.isUserInteractionEnabled = false
        answer2.isUserInteractionEnabled = false
        answer3.isUserInteractionEnabled = false
        answer4.isUserInteractionEnabled = false
        
        switch sender {
        case answer1:
            if correctAnswer == 1 {
                changeColor(button: 1, color: UIColor.green)
            } else {
                changeColor(button: 1, color: UIColor.red)
            }
        case answer2:
            if correctAnswer == 2 {
                changeColor(button: 2, color: UIColor.green)
            } else {
                changeColor(button: 2, color: UIColor.red)
            }
        case answer3:
            if correctAnswer == 3 {
                changeColor(button: 3, color: UIColor.green)
            } else {
                changeColor(button: 3, color: UIColor.red)
            }
        case answer4:
            if correctAnswer == 4 {
                changeColor(button: 4, color: UIColor.green)
            } else {
                changeColor(button: 4, color: UIColor.red)
            }
        default:
            return
        }
        
        let time = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(resetScenario), userInfo: nil, repeats: false)
        time.fireDate = Date().addingTimeInterval(1.25)
    }
    
    func changeColor(button: Int, color: UIColor) {
        switch button {
        case 1:
            UIView.animate(withDuration: 0.25, animations: {self.answer1.backgroundColor = color})
        case 2:
            UIView.animate(withDuration: 0.25, animations: {self.answer2.backgroundColor = color})
        case 3:
            UIView.animate(withDuration: 0.25, animations: {self.answer3.backgroundColor = color})
        case 4:
            UIView.animate(withDuration: 0.25, animations: {self.answer4.backgroundColor = color})
        default:
            return
        }
    }
    
    @objc func updateTextViewConstraint() { //View did load helper.
        questionFieldHeight.constant = CGFloat(20 * Double(Double(self.questionField.text.count) / 50).rounded(.up) + 10)
        if questionFieldHeight.constant == 30 {
            questionField.layer.cornerRadius = 15
        } else {
            questionField.layer.cornerRadius = 20
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.questionField.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
            self.questionField.textColor = StorageEnclave.Access.getCurrentTextColor()
        })
    }
    
    @objc func resetScenario() {
        UIView.animate(withDuration: 0.25, animations: {self.answer1.backgroundColor = self.defaultColor})
        UIView.animate(withDuration: 0.25, animations: {self.answer2.backgroundColor = self.defaultColor})
        UIView.animate(withDuration: 0.25, animations: {self.answer3.backgroundColor = self.defaultColor})
        UIView.animate(withDuration: 0.25, animations: {self.answer4.backgroundColor = self.defaultColor})
        
        answer1.isUserInteractionEnabled = true
        answer2.isUserInteractionEnabled = true
        answer3.isUserInteractionEnabled = true
        answer4.isUserInteractionEnabled = true
        
        loadQuestion()
    }

    




}


