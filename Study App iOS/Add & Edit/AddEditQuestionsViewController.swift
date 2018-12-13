//  AddEditQuestionsViewController.swift
//  Study App iOS
//
//  Created by Solomon Kieffer on 12/13/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class AddEditQuestionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var addNewButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var questionSetPicker: UIPickerView!
    @IBOutlet var questionSetDescriptionField: UITextView!
    @IBOutlet var questionSetNameField: UITextField!
    @IBOutlet var questionField: UITextField!
    @IBOutlet var answerField1: UITextField!
    @IBOutlet var answerField2: UITextField!
    @IBOutlet var answerField3: UITextField!
    @IBOutlet var answerField4: UITextField!
    @IBOutlet var correctAnswerSelecter: UISegmentedControl!
    @IBOutlet var addQuestionButton: UIButton!
    
    var questionWasChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Colors and Semantics
        correctAnswerSelecter.layer.cornerRadius = 20.0
        correctAnswerSelecter.layer.borderColor = StorageEnclave.Access.getCurrentSecondaryColor().cgColor
        correctAnswerSelecter.layer.borderWidth = 1.0
        correctAnswerSelecter.layer.masksToBounds = true
        
        view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        titleLabel.textColor = StorageEnclave.Access.getCurrentTextColor()
        questionSetNameField.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        questionSetDescriptionField.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        questionField.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        answerField1.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        answerField2.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        answerField3.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        answerField4.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        questionSetNameField.textColor = StorageEnclave.Access.getCurrentTextColor()
        questionSetDescriptionField.textColor = StorageEnclave.Access.getCurrentTextColor()
        questionField.textColor = StorageEnclave.Access.getCurrentTextColor()
        answerField1.textColor = StorageEnclave.Access.getCurrentTextColor()
        answerField2.textColor = StorageEnclave.Access.getCurrentTextColor()
        answerField3.textColor = StorageEnclave.Access.getCurrentTextColor()
        answerField4.textColor = StorageEnclave.Access.getCurrentTextColor()
        correctAnswerSelecter.tintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        returnButton.tintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        addNewButton.tintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        addQuestionButton.backgroundColor = StorageEnclave.Access.getCurrentSecondaryColor()
        addQuestionButton.tintColor = StorageEnclave.Access.getCurrentTextColor()
        //////////////////////
        questionField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answerField1.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answerField2.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answerField3.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answerField4.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        updateText()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddEditQuestionSetViewController {
            destination.didCreateQuestionSet = { didCreateQuestionSet in
                if didCreateQuestionSet {
                    self.questionSetPicker.selectRow(StorageEnclave.Access.getQuestionSetCount() - 1, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    @objc @IBAction func textFieldDidChange() {
        questionWasChanged = true
    }
    
    //MARK:- Picker View Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    } //Column Count
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return StorageEnclave.Access.getQuestionSetCount()
        } else {
            if StorageEnclave.Access.getQuestionSetCount() == 0 {
                return 0
            } else {
                return StorageEnclave.Access.getQuestionSet(at: pickerView.selectedRow(inComponent: 0))!.questions.count
            }
        }
    } //Row Count
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return StorageEnclave.Access.getQuestionSet(at: row)?.title
        } else {
            return "Question \(row + 1)"
        }
    } //Text in Rows
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
            updateText()
        } else {
            updateText()
        }
    } //Reloads the rows' texts when a new row is selected.
    //////////////////////////////
    
    func updateText() { //Loads all of the questions into the text fields.
        guard StorageEnclave.Access.getQuestionSetCount() != 0 else {
            questionSetNameField.isEnabled = false
            questionSetDescriptionField.isEditable = false
            return
        }
        guard StorageEnclave.Access.getQuestionSet(at: questionSetPicker.selectedRow(inComponent: 0))?.questions.count != 0 else {
            questionSetNameField.text = StorageEnclave.Access.getQuestionSet(at: questionSetPicker.selectedRow(inComponent: 0))!.title
            questionSetDescriptionField.text = StorageEnclave.Access.getQuestionSet(at: questionSetPicker.selectedRow(inComponent: 0))!.details
            questionField.text = ""
            answerField1.text = ""
            answerField2.text = ""
            answerField3.text = ""
            answerField4.text = ""
            correctAnswerSelecter.selectedSegmentIndex = -1
            correctAnswerSelecter.isEnabled = false
            questionSetNameField.isEnabled = true
            questionSetDescriptionField.isEditable = true
            answerField1.isEnabled = false
            answerField2.isEnabled = false
            answerField3.isEnabled = false
            answerField4.isEnabled = false
            correctAnswerSelecter.isEnabled = false
            return
        }
        
        let qset = StorageEnclave.Access.getQuestionSet(at: questionSetPicker.selectedRow(inComponent: 0))
        
        if qset!.style == .MultipleChoice {
            questionSetNameField.isEnabled = true
            questionSetDescriptionField.isEditable = true
            answerField1.isEnabled = true
            answerField2.isEnabled = true
            answerField3.isEnabled = true
            answerField4.isEnabled = true
            correctAnswerSelecter.isEnabled = true
            
            questionSetNameField.text = qset!.title
            questionSetDescriptionField.text = qset?.details
            questionField.text = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].question
            answerField1.text = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].answers[0]
            answerField2.text = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].answers[1]
            answerField3.text = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].answers[2]
            answerField4.text = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].answers[3]
            correctAnswerSelecter.selectedSegmentIndex = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].correctAnswer - 1
        } else {
            answerField2.isEnabled = false
            answerField3.isEnabled = false
            answerField4.isEnabled = false
            correctAnswerSelecter.isEnabled = false
            correctAnswerSelecter.selectedSegmentIndex = 0
            
            questionSetNameField.text = qset!.title
            questionSetDescriptionField.text = qset?.details
            questionField.text = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].question
            answerField1.text = qset!.questions[questionSetPicker.selectedRow(inComponent: 1)].answers[0]
            answerField2.text = ""
            answerField3.text = ""
            answerField4.text = ""
        }
    }
    
    @IBAction func returnToPrevious(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewQuestion(_ sender: Any) {
        if StorageEnclave.Access.getQuestionSetCount() != 0 {
            let newQuestion = Question(Question: "", Answers: ["", "", "", ""], CorrectAnswer: 1)
            StorageEnclave.Access.addQuestion(newQuestion, to: questionSetPicker.selectedRow(inComponent: 0))
            
            questionSetPicker.reloadComponent(1)
        } else {
            let alert = UIAlertController(title: "Can't Add Question", message: "You must add a question set first in order to add a question", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteQuestion(_ sender: UIButton) {
        if StorageEnclave.Access.getQuestionSet(at: questionSetPicker.selectedRow(inComponent: 0))!.questions.count > 0 {
            let alert = UIAlertController(title: "Delete Question?", message: "Are you sure you want to delete this question?", preferredStyle: .alert)
            let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                StorageEnclave.Access.removeQuestion(at: self.questionSetPicker.selectedRow(inComponent: 1), from: self.questionSetPicker.selectedRow(inComponent: 0))
                
                self.questionSetPicker.reloadComponent(1)
            }
            alert.addAction(cancleAction)
            alert.addAction(deleteAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteQuestionSet(_ sender: UIButton) {
        if StorageEnclave.Access.getQuestionSetCount() > 0 {
            let alert = UIAlertController(title: "Delete Question Set?", message: "Are you sure you want to delete this entire question set?", preferredStyle: .alert)
            let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                StorageEnclave.Access.removeQuestionSet(at: self.questionSetPicker.selectedRow(inComponent: 0))
                self.questionSetPicker.reloadAllComponents()
            }
            alert.addAction(cancleAction)
            alert.addAction(deleteAction)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if questionWasChanged {
            StorageEnclave.Access.changeTitleOfQuestionSet(at: questionSetPicker.selectedRow(inComponent: 0), to: questionSetNameField.text!)
            StorageEnclave.Access.changeDescriptionOfQuestionSet(at: questionSetPicker.selectedRow(inComponent: 0), to: questionSetDescriptionField.text!)
            StorageEnclave.Access.changeQuestionText(for: questionSetPicker.selectedRow(inComponent: 1),from: questionSetPicker.selectedRow(inComponent: 0), to: questionField.text!)
            StorageEnclave.Access.changeQuestionAnswer(for: questionSetPicker.selectedRow(inComponent: 1), from: questionSetPicker.selectedRow(inComponent: 0), to: answerField1.text!, at: 0)
            StorageEnclave.Access.changeQuestionAnswer(for: questionSetPicker.selectedRow(inComponent: 1), from: questionSetPicker.selectedRow(inComponent: 0), to: answerField2.text!, at: 1)
            StorageEnclave.Access.changeQuestionAnswer(for: questionSetPicker.selectedRow(inComponent: 1), from: questionSetPicker.selectedRow(inComponent: 0), to: answerField3.text!, at: 2)
            StorageEnclave.Access.changeQuestionAnswer(for: questionSetPicker.selectedRow(inComponent: 1), from: questionSetPicker.selectedRow(inComponent: 0), to: answerField4.text!, at: 3)
            StorageEnclave.Access.changeQuestionCorrectAnswer(for: questionSetPicker.selectedRow(inComponent: 1), from: questionSetPicker.selectedRow(inComponent: 0), to: correctAnswerSelecter.selectedSegmentIndex + 1)
        }
    }
}
