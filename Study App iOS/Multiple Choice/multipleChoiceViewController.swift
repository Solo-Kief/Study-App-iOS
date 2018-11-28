//  ViewController.swift
//  Trivia Game
//
//  Created by Solomon Kieffer on 10/8/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class multipleChoiceViewController: UIViewController {
    @IBOutlet var questionField: UITextView!
    @IBOutlet var questionFieldHeight: NSLayoutConstraint!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!
    
    
    static var questions: [Question] = []
    var correctAnswer = 0
    var defaultColor = UIColor()
    var lastQuestion = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultColor = answer1.backgroundColor!
        
        
        multipleChoiceViewController.questions = loadQuestion
        
        if multipleChoiceViewController.questions.count == 0 { //temporary for testing.
            buildDefaultQuestions()
        }
        
        loadQuestion()
    }

    func loadQuestion() {
        var selector = Int.random(in: 0..<multipleChoiceViewController.questions.count)
        while lastQuestion == selector && multipleChoiceViewController.questions.count != 1 {
            selector = Int.random(in: 0..<multipleChoiceViewController.questions.count)
        } //Prevents a question from repeating back-to-back.
        lastQuestion = selector
        
        questionField.text = multipleChoiceViewController.questions[selector].question
        answer1.setTitle(multipleChoiceViewController.questions[selector].answers[0], for: .normal)
        answer2.setTitle(multipleChoiceViewController.questions[selector].answers[1], for: .normal)
        answer3.setTitle(multipleChoiceViewController.questions[selector].answers[2], for: .normal)
        answer4.setTitle(multipleChoiceViewController.questions[selector].answers[3], for: .normal)
        correctAnswer = multipleChoiceViewController.questions[selector].correctAnswer
        
        UIView.animate(withDuration: 0.25, animations: {
            self.questionField.backgroundColor = UIColor.clear
            self.questionField.textColor = UIColor.clear
        })
        let time = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(updateTextViewConstraint), userInfo: nil, repeats: false)
        time.fireDate = Date().addingTimeInterval(0.35)
    }
    
   
    class QuestionModel {
        var questions: Array<Question>
        
        init () {
            questions = []
            questions.append(Question(question: "What year did WWII start?", answers:["1939", "1940", "1941", "1942"], correctAnswerIndex: 0))
            questions.append(Question(question: "What day was D-Day?", answers:["June 6, 1944", "June 16, 1944", "June 26, 1944", "June 16, 1943"], correctAnswerIndex: 0))
            questions.append(Question(question: "What country was first invaded by Germany?", answers:["France", "Belgium", "Poland", "Russia"], correctAnswerIndex: 2))
            questions.append(Question(question:"Which article of the Weimar Constitution granted Hitler emergency powers essentially allowing him to avoid parliament? ", answers:["Article 26", "Article 86", "Article 3", "Article 48"], correctAnswerIndex: 3))
            questions.append(Question(question:"Who was the leader of the Soviet Union during World War II?", answers:["Lenin", "Trotsky", "Stalin",  "Khruschev"], correctAnswerIndex: 2))
            questions.append(Question(question:"The main Axis powers of WWII Consisted of: Germany, _____, _____", answers:["Italy, Japan", "Russia, Japan", "Romania, Russia", "Japan, Romania"], correctAnswerIndex: 0))
        }
    }
    
    class Question {
        var question: String
        var answers: Array<String>
        var correctAnswerIndex: Int
        
        init(question: String,answers:Array<String>,correctAnswerIndex: Int) {
            self.question = question
            self.answers = answers
            self.correctAnswerIndex = correctAnswerIndex
        }
        
        func isGuessCorrect(guessNumber: Int) -> Bool {
            return correctAnswerIndex == Int(guessNumber-1)
        }
        
        var description:String {
            var str = "Multiple Choice = \(self.question)"
            for answer in answers {
                str += " " + answer
            }
            return str + " \(self.correctAnswerIndex)"
        }
    }
    
    var questionModel = QuestionModel()
    
    func randomQuestion(queModel:QuestionModel){
        var questions = questionModel.questions
        var randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        print(questions[randomIndex].description)
    }
    
    for _ in 1...5 {
    randomQuestion(queModel: questionModel)
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
            self.questionField.backgroundColor = UIColor.lightGray
            self.questionField.textColor = UIColor.black
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
