//
//  AddEditQuestionSetViewController.swift
//  Study App iOS
//
//  Created by Matthew Riley on 12/5/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit

class AddEditQuestionSetViewController: UIViewController {
    
    @IBOutlet weak var questionSetTitleTextField: UITextField!
    @IBOutlet weak var questionSetDetailsTextField: UITextField!
    @IBOutlet weak var setTypeSegmentedControl: UISegmentedControl!
    
    
    var questionSetToEdit: QuestionSet!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // touch screen to make keyboard go away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
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


