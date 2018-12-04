//
//  FlashCardViewController.swift
//  Study App iOS
//
//  Created by Brian Sadler on 11/27/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit
//Brian's File


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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets the colors for buttons and background
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.flipButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.flipButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.nextButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentTextColor()
        self.nextButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.flashCardTextView.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        
        
        nextButton.layer.cornerRadius = 10
        
        //Makes the current card the very first card in the array
        currentCard = flashCardArray[0]
        flashCardTextView.text =  currentCard.question
    
        
        

        // Do any additional setup after loading the view.
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
