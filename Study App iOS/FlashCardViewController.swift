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
    @IBOutlet weak var flashCardTextView: UITextView!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Array for unused flashcards
    var flashCardArray:[Question] = [Question(Question: "In which year did the Titanic sink?", Answers: ["1912"], CorrectAnswer: 0), Question(Question: "What nationality was Karl Marx?", Answers: ["German"], CorrectAnswer: 0)]
    
    //Array to put used flascards
    var usedFlashCards:[Question] = []
    
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
        if flashCardArray.count > 1 {
            usedFlashCards.append(currentCard)
            flashCardArray.remove(at: 0)
            currentCard = flashCardArray[0]
            flashCardTextView.text = currentCard.question
        }
        else {
            usedFlashCards.append(contentsOf: flashCardArray)
            flashCardArray = []
            flashCardArray.append(contentsOf: usedFlashCards)
            currentCard = flashCardArray[0]
            flashCardTextView.text = currentCard.question
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Impliment the same function found in the multiple choice screen. Adapt as needed.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidAppear(false)
        
        //Makes the current card the very first card in the array
        currentCard = flashCardArray[0]
        flashCardTextView.text =  currentCard.question
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Sets the colors for buttons and background
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.flipButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.flipButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.nextButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.nextButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.flashCardTextView.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        flashCardTextView.textColor = StorageEnclave.Access.getCurrentTextColor()
    }
}
