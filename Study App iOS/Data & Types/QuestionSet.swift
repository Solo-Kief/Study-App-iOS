//  QuestionSet.swift
//  Study App iOS
//
//  Created by Solomon Kieffer on 11/24/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

//This class will contain sets of questions, so that users will be able to make and use seperate question sets.

class QuestionSet: NSObject, NSCoding {
    var questions: [Question] = []
    var title: String
    var details: String?
    var style: Style
    
    enum Style: Int {
        case MultipleChoice = 0
        case FlashCard
        case Blank
    }
    
    init(Title: String, Style: Style) {
        self.title = Title
        self.style = Style
    }
    
    init(Title: String, Details: String?, Questions: [Question], Style: Style) {
        self.title = Title
        self.details = Details
        self.questions = Questions
        self.style = Style
    }
    
    internal convenience required init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "Title") as! String
        let details = aDecoder.decodeObject(forKey: "Details") as? String
        let questions = aDecoder.decodeObject(forKey: "Questions") as! [Question]
        let style = aDecoder.decodeObject(forKey: "Style") as! Int
        
        self.init(Title: title, Details: details, Questions: questions, Style: QuestionSet.Style(rawValue: style)!)
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "Title")
        aCoder.encode(self.details, forKey: "Details")
        aCoder.encode(self.questions, forKey: "Questions")
        aCoder.encode(self.style.rawValue, forKey: "Style")
    }
}
