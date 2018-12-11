//  SettingsViewController.swift
//  Trivia Game
//
//  Created by Solomon Kieffer on 10/9/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var UIObjectPicker: UIPickerView!
    @IBOutlet var RedColorPicker: UISlider!
    @IBOutlet var GreenColorPicker: UISlider!
    @IBOutlet var BlueColorPicker: UISlider!
    @IBOutlet var sampleText: UILabel!
    
    override func viewDidLoad() {
        view.backgroundColor = StorageEnclave.Access.getCurrentPrimaryColor()
        RedColorPicker.thumbTintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        GreenColorPicker.thumbTintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        BlueColorPicker.thumbTintColor = StorageEnclave.Access.getCurrentSecondaryColor()
        UIObjectPicker.backgroundColor = StorageEnclave.Access.getCurrentTertiaryColor()
        
        UIObjectPicker.selectRow(0, inComponent: 0, animated: true)
        pickerView(UIObjectPicker, didSelectRow: 0, inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Background Color"
        case 1:
            return "Button Color"
        case 2:
            return "Question Color"
        case 3:
            return "Text Color"
        default:
            return "Error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let SelectedColor: UIColor
        
        switch row {
        case 0:
            SelectedColor = StorageEnclave.Access.getCurrentPrimaryColor()
        case 1:
            SelectedColor = StorageEnclave.Access.getCurrentSecondaryColor()
        case 2:
            SelectedColor = StorageEnclave.Access.getCurrentTertiaryColor()
        case 3:
            SelectedColor = StorageEnclave.Access.getCurrentTextColor()
        default:
            SelectedColor = .white
        }
        
        if SelectedColor.cgColor.components?.count == 4 {
            RedColorPicker.value = Float(SelectedColor.cgColor.components![0])
            GreenColorPicker.value = Float(SelectedColor.cgColor.components![1])
            BlueColorPicker.value = Float(SelectedColor.cgColor.components![2])
        } else {
            RedColorPicker.value = Float(SelectedColor.cgColor.components![0])
            GreenColorPicker.value = Float(SelectedColor.cgColor.components![0])
            BlueColorPicker.value = Float(SelectedColor.cgColor.components![0])
        }
    }
    
    @IBAction func onValueChange(_ sender: Any) {
        switch UIObjectPicker.selectedRow(inComponent: 0) {
        case 0:
            view.backgroundColor = UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0)
        case 1:
            let newColor = UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0)
            RedColorPicker.thumbTintColor = newColor
            GreenColorPicker.thumbTintColor = newColor
            BlueColorPicker.thumbTintColor = newColor
        case 2:
            UIObjectPicker.backgroundColor = UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0)
        case 3:
            sampleText.textColor = UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0)
        default:
            fatalError("Failed to update UI color.")
        }
    }
    
    @IBAction func onSpecialTouch(_ sender: Any) {
        if UIObjectPicker.selectedRow(inComponent: 0) == 3 {
            UIView.animate(withDuration: 0.2, animations: {
                self.UIObjectPicker.alpha = 0
            })
            let waiter = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.sampleText.alpha = 1
                    })
            }
            waiter.fireDate = Date().addingTimeInterval(0.2)
        }
    }
    
    @IBAction func onRelease(_ sender: Any) {
        switch UIObjectPicker.selectedRow(inComponent: 0) {
        case 0:
            StorageEnclave.Access.setNewPrimaryColor(UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0))
        case 1:
            StorageEnclave.Access.setNewSecondaryColor(UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0))
        case 2:
            StorageEnclave.Access.setNewTertiaryColor(UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0))
        case 3:
            StorageEnclave.Access.setNewTextColor(UIColor(red: CGFloat(RedColorPicker.value), green: CGFloat(GreenColorPicker.value), blue: CGFloat(BlueColorPicker.value), alpha: 1.0))
            
            if sampleText.alpha > 0 {
                UIView.animate(withDuration: 0.2) {
                    self.sampleText.alpha = 0
                }
                
                let waiter = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.UIObjectPicker.alpha = 1
                    })
                }
                waiter.fireDate = Date().addingTimeInterval(0.2)
            }
        default:
            fatalError("Failed to store new UI color.")
        }
    }
    
    @IBAction func resetAllColors(_ sender: Any) {
        let alert = UIAlertController(title: "Reset UI Colors", message: "You are about to restore all colors to their default settings. Are you sure you want to do this?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) { _ in
            StorageEnclave.Access.restoreDefaultColors()
            self.viewDidLoad()
        }
        
        alert.addAction(cancleAction)
        alert.addAction(resetAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteAllQuestions(_ sender: Any) {
        let alert = UIAlertController(title: "Delete All Questions", message: "You are about to DELETE ALL QUESTIONS currently stored on the app. Are you absolutely certian that you wish to do this?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let resetAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            StorageEnclave.Access.deleteAllQuestions()
        }
        
        alert.addAction(cancleAction)
        alert.addAction(resetAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func masterReset(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Everything", message: "You are about to reset everything in the app. This will restore all of your settings to default and will DELETE ALL QUESTIONS. Are you absolutely sure you want to do this?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let resetAction = UIAlertAction(title: "Reset Everything", style: .destructive) { _ in
            StorageEnclave.Access.deleteAllQuestions()
            StorageEnclave.Access.restoreDefaultColors()
            self.viewDidLoad()
        }
        
        alert.addAction(cancleAction)
        alert.addAction(resetAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
