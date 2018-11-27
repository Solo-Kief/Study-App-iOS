//  Question.swift
//  Trivia Game
//
//  Created by Solomon Kieffer on 10/9/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

class Question: NSObject, NSCoding {
    var question: String
    var answers: [String]
    var correctAnswer: Int
    
    init(Question: String, Answers: [String], CorrectAnswer: Int) {
        question = Question
        answers = Answers
        correctAnswer = CorrectAnswer
    }
    
    internal required convenience init?(coder aDecoder: NSCoder) {
        let q = aDecoder.decodeObject(forKey: "question") as! String
        let a = aDecoder.decodeObject(forKey: "answers") as! [String]
        let c = aDecoder.decodeInteger(forKey: "correctAnswer")
        self.init(Question: q, Answers: a, CorrectAnswer: c)
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(question , forKey: "question")
        aCoder.encode(answers , forKey: "answers")
        aCoder.encode(correctAnswer , forKey: "correctAnswer")
    }
}
