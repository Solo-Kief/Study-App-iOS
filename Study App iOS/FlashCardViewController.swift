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
    //Outlets for buttons and flashcard image
    @IBOutlet weak var flashCardImage: UIImageView!
    @IBOutlet weak var questionAnswerLabel: UILabel!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashCardArray:[Question] = [Question(Question: "In which year did the Titanic sink?", Answers: ["1912"], CorrectAnswer: 0), Question(Question: "What nationality was Karl Marx?", Answers: ["German"], CorrectAnswer: 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Sets the colors for buttons and background
        self.view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        self.flipButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentSecondaryColor()
        self.nextButton.titleLabel?.textColor = StorageEnclave.Access.getCurrentSecondaryColor()
        
        

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
