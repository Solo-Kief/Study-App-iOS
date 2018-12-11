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
        if currentCard.question == flashCardTextView.text {
            flashCardTextView.text = currentCard.answers[0]
        }
        else {
            flashCardTextView.text = currentCard.question
        }
        
    }
    
    //Function to switch a new card
    @IBAction func nextButtonPressed(_ sender: Any) {
        getNewFlashCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Sets the colors for buttons and background
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.flipButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.flipButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.nextButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.nextButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.questionSetButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.questionSetButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.flashCardTextView.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        flashCardTextView.textColor = StorageEnclave.Access.getCurrentTextColor()
    }
    
    @IBAction func questionSetButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showQuestionSetsScreen", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionSetCollectionViewController {
            
            destination.selectedStyle = questionSetStyle
            
        }
    }
    func populateFlashCards() {
        liveQuestionSet
    }
    func getNewFlashCard() {
        if (liveQuestionSet?.questions.count)! > 1 {
            usedFlashCards.append(currentCard)
            liveQuestionSet?.questions.remove(at: 0)
            currentCard = liveQuestionSet?.questions[0]
            flashCardTextView.text = currentCard.question
        }
        else {
            liveQuestionSet?.questions = self.usedFlashCards
            usedFlashCards.removeAll()
            getNewFlashCard()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidAppear(false)
        
        //populate flashcards with function call
        populateFlashCards()
        
        
    }
}


