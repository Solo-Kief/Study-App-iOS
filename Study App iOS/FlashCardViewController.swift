//  FlashCardViewController.swift
//  Study App iOS
//
//  Created by Brian Sadler on 11/27/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit
//Brian's File
// !IMPORTANT! You need to change this screen to use an optional QuestionSet instead of the current "flashCardArray"
// array of questions. The value should be called "activeQuestionSet" and must be optional!

// This screen needs to be able to handle "activeQuestionSet" having no question set loaded in.
// Look at the other two screens to see how this might be handled.

// I noticed that you are using an array to keep track or which questions have been used.
// I recommend changing it to simply use the index of the questions instead.

class FlashCardViewController: UIViewController {
    //Outlets for buttons and flashcard
    @IBOutlet weak var questionSetButton: UIButton!
    @IBOutlet weak var flashCardTextView: UITextView!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var changeQuestionsButton: UIButton!
    var liveQuestionSet: QuestionSet?
    var questionSetStyle = QuestionSet.Style.Blank
    var lastFlashCard = -1
    var randomIndex: Int!
    
    //empty array for used flashcard storage
    var usedFlashCards: [Question] = []
    
    
    //Setup for getting the card the user sees
    var currentCard: Question!
    
    //Function to show the opposite sides of the flashcard
    @IBAction func flipButtonPressed(_ sender: Any) {
     flipFlashCard()
    }
    
    //Function to switch a new card
    @IBAction func nextButtonPressed(_ sender: Any) {
        getNewFlashCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Sets the colors for buttons and background
        changeQuestionsButton.tintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.flipButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.flipButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.nextButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.nextButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.flashCardTextView.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        flashCardTextView.textColor = StorageEnclave.Access.getCurrentTextColor()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionSetCollectionViewController {
            destination.selectedStyle = .Blank
            destination.newQuestionSet = { newQuestionSet in
                self.liveQuestionSet = newQuestionSet
                self.getNewFlashCard()
            }
        }
    }
    
    func getNewFlashCard() {
        guard liveQuestionSet != nil else {
            return
        }
        
        if let liveQuestionSet = liveQuestionSet {
            if liveQuestionSet.questions.count > 0 {
                //Get a random index from 0 to 1 less then the amount of elements in the array
                randomIndex = Int.random(in: 0..<liveQuestionSet.questions.count)
                //Set currentCard equal to the question that is at the random index in the questions array
                currentCard = liveQuestionSet.questions[randomIndex]
                flashCardTextView.text = currentCard.question
            } else {
                liveQuestionSet.questions = self.usedFlashCards
                usedFlashCards.removeAll()
                //Get a new question
                getNewFlashCard()
            }
           
        } else {
            nextButton.isHidden = true
            flipButton.isHidden = true
        }
        
    }
    func flipFlashCard() {
        guard currentCard != nil else {
            return
        }
        if currentCard.question == flashCardTextView.text {
            flashCardTextView.text = currentCard.answers[0]
        }
        else {
            flashCardTextView.text = currentCard.question
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidAppear(false)
        
        if StorageEnclave.Access.getDefault(for: QuestionSet.Style.Blank) == nil {
            flashCardTextView.text = "There are no questions currently loaded."
            liveQuestionSet = nil
        } else {
            liveQuestionSet =
                StorageEnclave.Access.getQuestionSet(at: StorageEnclave.Access.getDefault(for: QuestionSet.Style.Blank)!)
            
        }
        
        
    }
}


