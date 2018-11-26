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
// Impliment Question lists locally.
// Impliment Question sets locally. I.E. It's seperate sets of questions that one can select from
// Impliment persistance for the questions and question lists.
// Impliment data access and modifying operations.
// Impliment application settings that will be determined at a later date.
// Make all data sets and application settings locally persistant.
// Bonus - Make a method for file based importation and exprotation for questions, question sets, themes, and settings.

class StorageEnclave: NSObject, NSCoding {
    //MARK:- Core Values
    static let Access = StorageEnclave()
    var QuestionSets: [QuestionSet]?
    
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.QuestionSets, forKey: "QuestionSets")
    }
    
    static func save() {
        let storedData = NSKeyedArchiver.archivedData(withRootObject: Access)
        UserDefaults.standard.set(storedData, forKey: "StorageEnclave")
    }
    
    //MARK:- I'll put a name here later.
}
