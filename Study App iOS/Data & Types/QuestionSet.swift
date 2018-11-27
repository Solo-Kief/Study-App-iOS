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
    
    enum Style {
        case MultipleChoice
        case FlashCard
        case Blank
    }
    
    init(Title: String) {
        self.title = Title
    }
    
    init(Title: String, Details: String?, Questions: [Question]) {
        self.title = Title
        self.details = Details
        self.questions = Questions
    }
    
    internal convenience required init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "Title") as! String
        let details = aDecoder.decodeObject(forKey: "Details") as? String
        let questions = aDecoder.decodeObject(forKey: "Questions") as! [Question]
        
        self.init(Title: title, Details: details, Questions: questions)
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "Title")
        aCoder.encode(self.details, forKey: "Details")
        aCoder.encode(self.questions, forKey: "Questions")
    }
}
