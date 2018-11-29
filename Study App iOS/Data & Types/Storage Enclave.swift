//  Storage Enclave.swift
//  Study App iOS
//
//  Created by Solomon Kieffer on 11/24/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation
import UIKit

// The following is the purpose and goals of this file.
//
// Purpose: This file intends to handle non-specific application data. It will perform all data operations,
// provide data to the modules that request it, provide a singleton of data avaliable app wide, and be
// self persistant.

// To-Do list:
//
// Impliment data access and modifying operations.
// Impliment application settings that will be determined at a later date.
// Bonus - Make a method for file based importation and exprotation for questions, question sets, themes, and settings..

class StorageEnclave: NSObject, NSCoding {
    //MARK:- Core Values
    static let Access = StorageEnclave()
    private var QuestionSets: [QuestionSet] = []
    
    //MARK:- Settings Values
    private var PrimaryColor = UIColor.darkGray
    private var SecondaryColor = UIColor(red: 255, green: 143, blue: 54, alpha: 1)
    private var TextColor = UIColor.white
    
    //MARK:- Core Setup
    private override init() {
        if let storedData = UserDefaults.standard.value(forKey: "StorageEnclave") {
            let enclave = NSKeyedUnarchiver.unarchiveObject(with: storedData as! Data) as! StorageEnclave
            
            QuestionSets = enclave.QuestionSets
            PrimaryColor = enclave.PrimaryColor
            SecondaryColor = enclave.SecondaryColor
            TextColor = enclave.TextColor
        }
    }
    
    private init(QuestionSets: [QuestionSet], PrimaryColor: UIColor, SecondaryColor: UIColor, TextColor: UIColor) {
        self.QuestionSets = QuestionSets
        self.PrimaryColor = PrimaryColor
        self.SecondaryColor = SecondaryColor
        self.TextColor = TextColor
    }
    
    internal required convenience init?(coder aDecoder: NSCoder) {
        let QuestionSets = aDecoder.decodeObject(forKey: "QuestionSets") as! [QuestionSet]
        let PrimaryColor = aDecoder.decodeObject(forKey: "PrimaryColor") as! UIColor
        let SecondaryColor = aDecoder.decodeObject(forKey: "SecondaryColor") as! UIColor
        let TextColor = aDecoder.decodeObject(forKey: "TextColor") as! UIColor
        
        self.init(QuestionSets: QuestionSets, PrimaryColor: PrimaryColor, SecondaryColor: SecondaryColor, TextColor: TextColor)
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.QuestionSets, forKey: "QuestionSets")
        aCoder.encode(self.PrimaryColor, forKey: "PrimaryColor")
        aCoder.encode(self.SecondaryColor, forKey: "SecondaryColor")
        aCoder.encode(self.TextColor, forKey: "TextColor")
    }
    
    private static func save() {
        let storedData = NSKeyedArchiver.archivedData(withRootObject: Access)
        UserDefaults.standard.set(storedData, forKey: "StorageEnclave")
    }
    
    //MARK:- QuestionSet Return Functions
    func getQuestionSet(at index: Int) -> QuestionSet? {
        guard index < QuestionSets.count && index >= 0 else {
            return nil
        }
        
        return QuestionSets[index]
    }
    
    func getQuestionSetCount() -> Int {
        return QuestionSets.count
    }
    
    func getQuestionSetCount(ofStyle style: QuestionSet.Style) -> Int {
        var count = 0
        
        for set in QuestionSets {
            if set.style == style {
                count += 1
            }
        }
        
        return count
    }
    
    func getQuestionSetIndices(ofStyle style: QuestionSet.Style) -> [Int] {
        var indicies: [Int] = []
        
        for (i, set) in QuestionSets.enumerated() {
            if set.style == style {
                indicies.append(i)
            }
        }
        
        return indicies
    }
    
    //MARK:- QuestionSet List Manipulation Functions
    func addQuestionSet(_ questionSet: QuestionSet) {
        QuestionSets.append(questionSet)
        StorageEnclave.save()
    }
    
    func removeQuestionSet(at index: Int) {
        guard index < QuestionSets.count && index >= 0 else {
            return
        }
        
        QuestionSets.remove(at: index)
        StorageEnclave.save()
    }
    
    func removeAllQuestionSets(ofStyle style: QuestionSet.Style) {
        QuestionSets.removeAll { (thisSet) -> Bool in
            return thisSet.style == style
        }
        
        StorageEnclave.save()
    }
    
    //MARK:- QuestionSet Modification Functions
    func changeTitleOfQuestionSet(at index: Int, to newTitle: String) {
        guard index < QuestionSets.count && index >= 0 else {
            return
        }
        
        QuestionSets[index].title = newTitle
        StorageEnclave.save()
    }
    
    func changeDescriptionOfQuestionSet(at index: Int, to newDescription: String?) {
        guard index < QuestionSets.count && index >= 0 else {
            return
        }
        
        QuestionSets[index].details = newDescription
        StorageEnclave.save()
    }
    
    func addQuestion(_ question: Question, to questionSet: Int) {
        QuestionSets[questionSet].questions.append(question)
        StorageEnclave.save()
    }
    
    func removeQuestion(at question: Int, from questionSet: Int) {
        QuestionSets[questionSet].questions.remove(at: question)
        StorageEnclave.save()
    }
    
    func changeQuestionText(for question: Int, from questionSet: Int, to newQuestion: String) {
        QuestionSets[questionSet].questions[question].question = newQuestion
        StorageEnclave.save()
    }
    
    func changeQuestionCorrectAnswer(for question: Int, from questionSet: Int, to newCorrectAnswer: Int) {
        QuestionSets[questionSet].questions[question].correctAnswer = newCorrectAnswer
        StorageEnclave.save()
    }
    
    func changeQuestionAnswer(for question: Int, from questionSet: Int, to newAnswer: String, at answer: Int) {
        QuestionSets[questionSet].questions[question].answers[answer] = newAnswer
        StorageEnclave.save()
    }
    
    //MARK:- User Settings
    func setNewPrimaryColor(_ newColor: UIColor) {
        self.PrimaryColor = newColor
        StorageEnclave.save()
    }
    
    func setNewSecondaryColor(_ newColor: UIColor) {
        self.SecondaryColor = newColor
        StorageEnclave.save()
    }
    
    func setNewTextColor(_ newColor: UIColor) {
        self.TextColor = newColor
        StorageEnclave.save()
    }
    
    func getCurrentPrimaryColor() -> UIColor {
        return PrimaryColor
    }
    
    func getCurrentSecondaryColor() -> UIColor {
        return SecondaryColor
    }
    
    func getCurrentTextColor() -> UIColor {
        return TextColor
    }
}
