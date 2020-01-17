//
//  FirstViewController.swift
//  Lift Timer
//
//  Created by Nick Simpson on 7/29/19.
//  Copyright © 2019 nlsimpson. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    var setCount = 1
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var setNumberLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        layer.startPoint = CGPoint(x: 1, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 0)
        view.layer.insertSublayer(layer, at: 0)
        
        clearButton.isEnabled = false
        minusButton.isEnabled = false
        resetButton.isEnabled = false
        startButton.layer.cornerRadius = 37
        
        clearButton.layer.cornerRadius = 37
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    @IBAction func clearDidTap(_ sender: Any) {
        counter = 0.0
        clockLabel.text = "00:00:00.00"
        clearButton.isEnabled = false
        startButton.isEnabled = true
        
        isTimerRunning = false
        timer.invalidate()
        startButton.setTitle("Start", for: UIControl.State.normal)
        startButton.backgroundColor = UIColor.green
    }
    
    @IBAction func startDidTap(_ sender: Any) {
        if !isTimerRunning{
            startButton.setTitle("Stop", for: UIControl.State.normal)
            startButton.backgroundColor = UIColor.red
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
            
            isTimerRunning = true
            
            clearButton.isEnabled = true
        }else{
            startButton.setTitle("Start", for: UIControl.State.normal)
            startButton.backgroundColor = UIColor.green
            isTimerRunning = false
            timer.invalidate()
        }
        
    }
    
    
    @IBAction func minusDidTap(_ sender: Any) {
        if setCount > 2{
            setCount -= 1
            setNumberLabel.text = "\(setCount)"
            plusButton.isEnabled = true
        }else{
            setCount -= 1
            setNumberLabel.text = "\(setCount)"
            minusButton.isEnabled = false
            resetButton.isEnabled = false
        }
    }
    
    
    @IBAction func plusDidTap(_ sender: Any) {
        if setCount < 98{
            resetButton.isEnabled = true
            setCount += 1
            setNumberLabel.text = "\(setCount)"
            minusButton.isEnabled = true
        }else {
            setCount += 1
            setNumberLabel.text = "\(setCount)"
            minusButton.isEnabled = true
            resetButton.isEnabled = true
            plusButton.isEnabled = false
        }
    }
    
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        setCount = 1
        minusButton.isEnabled = false
        resetButton.isEnabled = false
        setNumberLabel.text = "\(setCount)"
    }
    
    @objc func startTimer(){
        counter += 0.1
        
        let floorCounter = Int(floor(counter))
        let hour = floorCounter / 3600
        var hourString = "\(hour)"
        
        if hour<10 {
            hourString = "0\(hour)"
        }
        
        let minute = (floorCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (floorCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        let milisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        var milisecondString = milisecond
        if milisecond.count < 2{
            milisecondString = "0" + milisecond
        }
        
        clockLabel.text = hourString + ":" + minuteString + ":" + secondString + "." + milisecondString
    }
}

