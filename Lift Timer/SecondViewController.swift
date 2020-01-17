//
//  SecondViewController.swift
//  Lift Timer
//
//  Created by Nick Simpson on 7/29/19.
//  Copyright © 2019 nlsimpson. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var squatText: UITextField!
    @IBOutlet weak var bpText: UITextField!
    @IBOutlet weak var deadliftText: UITextField!
    @IBOutlet weak var rowText: UITextField!
    @IBOutlet weak var ohpText: UITextField!
    
    @IBOutlet weak var weightSwitch: UISwitch!
    @IBOutlet weak var weightIndex: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    
    @IBOutlet weak var squatTextButton: UIButton!
    @IBOutlet weak var bptextButton: UIButton!
    @IBOutlet weak var deadliftTextButton: UIButton!
    @IBOutlet weak var rowTextButton: UIButton!
    @IBOutlet weak var ohpTextButton: UIButton!
    
    struct Keys{
        static let squatCurrentWeight = "squatCurrentWeight"
        static let squatMaxWeight = "squatMaxWeight"
        static let bpCurrentWeight = "bpCurrentWeight"
        static let bpMaxWeight = "bpMaxWeight"
        static let deadliftCurrentWeight = "deadliftCurrentWeight"
        static let deadliftMaxWeight = "deadliftMaxWeight"
        static let rowCurrentWeight = "rowCurrentWeight"
        static let rowMaxWeight = "rowMaxWeight"
        static let ohpCurrentWeight = "ohpCurrentWeight"
        static let ohpMaxWeight = "ohpMaxWeight"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkWeights()
        
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        layer.startPoint = CGPoint(x: 1, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 0)
        view.layer.insertSublayer(layer, at: 0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        if weightSwitch.isOn{
            saveCurrentWeights()
        }else{
            saveMaxWeights()
        }
    }

    @IBAction func didSwitch(_ sender: Any) {
        if weightSwitch.isOn{
            weightIndex.text = "Current"
            displayCurrentWeights()
        }else{
            weightIndex.text = "Max"
            displayMaxWeights()
        }
    }
    @IBAction func switchButtonDidTap(_ sender: Any) {
        if weightIndex.text == "Current"{
            weightIndex.text = "Max"
            weightSwitch.isOn = false
            displayMaxWeights()
        }else{
            weightIndex.text = "Current"
            weightSwitch.isOn = true
            displayCurrentWeights()
        }
    }


    @IBAction func sqautTapped(_ sender: Any) {
        squatText.becomeFirstResponder()
    }
    
    @IBAction func bpTapped(_ sender: Any) {
        bpText.becomeFirstResponder()
    }
    
    @IBAction func deadliftTapped(_ sender: Any) {
        deadliftText.becomeFirstResponder()
    }
    
    @IBAction func rowTapped(_ sender: Any) {
        rowText.becomeFirstResponder()
    }
    
    @IBAction func ohpTapped(_ sender: Any) {
        ohpText.becomeFirstResponder()
    }
    
    func saveCurrentWeights(){
        defaults.set(squatText.text!, forKey: Keys.squatCurrentWeight)
        defaults.set(bpText.text!, forKey: Keys.bpCurrentWeight)
        defaults.set(deadliftText.text!, forKey: Keys.deadliftCurrentWeight)
        defaults.set(rowText.text!, forKey: Keys.rowCurrentWeight)
        defaults.set(ohpText.text!, forKey: Keys.ohpCurrentWeight)
    }
    
    func saveMaxWeights(){
        defaults.set(squatText.text!, forKey: Keys.squatMaxWeight)
        defaults.set(bpText.text!, forKey: Keys.bpMaxWeight)
        defaults.set(deadliftText.text!, forKey: Keys.deadliftMaxWeight)
        defaults.set(rowText.text!, forKey: Keys.rowMaxWeight)
        defaults.set(ohpText.text!, forKey: Keys.ohpMaxWeight)
    }
    
    func checkWeights(){
        let squatWeight = defaults.value(forKey: Keys.squatCurrentWeight) as? String ?? ""
        let bpWeight = defaults.value(forKey: Keys.bpCurrentWeight) as? String ?? ""
        let deadliftWeight = defaults.value(forKey: Keys.deadliftCurrentWeight) as? String ?? ""
        let rowWeight = defaults.value(forKey: Keys.rowCurrentWeight) as? String ?? ""
        let ohpWeight = defaults.value(forKey: Keys.ohpCurrentWeight) as? String ?? ""
        
        squatText.text = squatWeight
        bpText.text = bpWeight
        deadliftText.text = deadliftWeight
        rowText.text = rowWeight
        ohpText.text = ohpWeight
    }
    
    func displayCurrentWeights(){
        squatText.text! = defaults.value(forKey: Keys.squatCurrentWeight) as? String ?? ""
        bpText.text! = defaults.value(forKey: Keys.bpCurrentWeight) as? String ?? ""
        deadliftText.text! = defaults.value(forKey: Keys.deadliftCurrentWeight) as? String ?? ""
        rowText.text! = defaults.value(forKey: Keys.rowCurrentWeight) as? String ?? ""
        ohpText.text! = defaults.value(forKey: Keys.ohpCurrentWeight) as? String ?? ""
    }
    
    func displayMaxWeights(){
        squatText.text! = defaults.value(forKey: Keys.squatMaxWeight) as? String ?? ""
        bpText.text! = defaults.value(forKey: Keys.bpMaxWeight) as? String ?? ""
        deadliftText.text! = defaults.value(forKey: Keys.deadliftMaxWeight) as? String ?? ""
        rowText.text! = defaults.value(forKey: Keys.rowMaxWeight) as? String ?? ""
        ohpText.text! = defaults.value(forKey: Keys.ohpMaxWeight) as? String ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        dismissKeyboard()
        return true
    }
}

