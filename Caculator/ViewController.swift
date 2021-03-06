//
//  ViewController.swift
//  Caculator
//
//  Created by Rui Wang on 18/1/27.
//  Copyright © 2018年 Rui Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var diplay: UILabel!
    
    var userIsInTheMiddleOfTyping = false

    @IBAction func touchDigit(sender: UIButton){
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = diplay!.text!
            diplay!.text = textCurrentlyInDisplay + digit
        }
        else {
            diplay!.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        
        print("\(digit) was called")
    }
    
    var displayValue: Double {
        get {
            return Double(diplay.text!)!
        }
        set {
            diplay.text = String(newValue)
            
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        
        if let mathematicalSymbol = sender.currentTitle {
            
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }

}

