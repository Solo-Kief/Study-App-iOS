//
//  FillInTheBlankViewController.swift
//  Study App iOS
//
//  Created by Matthew Riley on 11/27/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit

class FillInTheBlankViewController: UIViewController {
    
    @IBOutlet weak var statementLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    
    //Current fill in the blank question being answered
    var currentFillInTheBlankQuestion: Question! {
        didSet {
            //Whenever a new currentFillInTheBlankQuestion is set, update the UI for that new question
            statementLabel.text = currentFillInTheBlankQuestion.question
        }
    }
    
    //Array of fill in the blank questions
    var fillInTheBlankQuestions: [Question] = []
    
    //Array that holds the questions that have been answered
    var completedFillInTheBlankQuestions: [Question] = []
    
    //Stores the index of the currentFillInTheBlankQuestion
    var randomIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //INSERT FUNCTIONS HERE
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

