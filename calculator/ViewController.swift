//
//  ViewController.swift
//  calculator
//
//  Created by Deekshith Bellare on 10/08/16.
//  Copyright © 2016 Rakshith Bellare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        addToHistory(digit)
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
           enter()
        }
        if let operation = sender.currentTitle {
              if let result = brain.performOperation(operation)
            {
                displayValue = result
            } else {
                displayValue = 0
            }
            addToHistory(operation)
        }
        
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        addToHistory(" ")
    }
    
    @IBAction func clear() {
        userIsInTheMiddleOfTyping = false
        brain.clear()
        displayValue = 0
        history.text = " "
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        } set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }
    
    func addToHistory(copyToAddToHistory: String) {
        history.text = history.text! + copyToAddToHistory
    }


}

