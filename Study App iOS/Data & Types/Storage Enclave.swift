//  Storage Enclave.swift
//  Study App iOS
//
//  Created by Solomon Kieffer on 11/24/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

// The following is the purpose and goals of this file.
//
// Purpose: This file intends to handle non-specific application data. It will perform all data operations,
// provide data to the modules that request it, provide a singleton of data avaliable app wide, and be
// self persistant.

// To-Do list:
//
// Impliment data access and modifying operations.
// Impliment application settings that will be determined at a later date.
// Bonus - Make a method for file based importation and exprotation for questions, question sets, themes, and settings.

class StorageEnclave: NSObject, NSCoding {
    //MARK:- Core Values
    static let Access = StorageEnclave()
    private var QuestionSets: [QuestionSet] = []
    
    //MARK:- Core Setup
    private override init() {
        if let storedData = UserDefaults.standard.value(forKey: "StorageEnclave") {
            let enclave = NSKeyedUnarchiver.unarchiveObject(with: storedData as! Data) as! StorageEnclave
            
            QuestionSets = enclave.QuestionSets
        }
    }
    
    private init(QuestionSets: [QuestionSet]) {
        self.QuestionSets = QuestionSets
    }
    
    internal required convenience init?(coder aDecoder: NSCoder) {
        let QuestionSets = aDecoder.decodeObject(forKey: "QuestionSets") as! [QuestionSet]
        
        self.init(QuestionSets: QuestionSets)
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.QuestionSets, forKey: "QuestionSets")
    }
    
    private static func save() {
        let storedData = NSKeyedArchiver.archivedData(withRootObject: Access)
        UserDefaults.standard.set(storedData, forKey: "StorageEnclave")
    }
    
    //MARK:- QuestionSet Return Functions
    func returnQuestionSet(at index: Int) -> QuestionSet? {
        guard index < QuestionSets.count && index >= 0 else {
            return nil
        }
        
        return QuestionSets[index]
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
    }
    
    func removeQuestion(at question: Int, from questionSet: Int) {
        QuestionSets[questionSet].questions.remove(at: question)
    }
    
    func changeQuestionText(for question: Int, from questionSet: Int, to newQuestion: String) {
        QuestionSets[questionSet].questions[question].question = newQuestion
    }
    
    func changeQuestionCorrectAnswer(for question: Int, from questionSet: Int, to newCorrectAnswer: Int) {
        QuestionSets[questionSet].questions[question].correctAnswer = newCorrectAnswer
    }
    
    func changeQuestionAnswer(for question: Int, from questionSet: Int, to newAnswer: String, at answer: Int) {
        QuestionSets[questionSet].questions[question].answers[answer] = newAnswer
    }
}
