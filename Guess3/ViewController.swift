//
//  ViewController.swift
//  Guess3
//
//  Created by KARTHIK on 5/17/15.
//  Copyright (c) 2015 Rizwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var output: UITextView!
    
    var guesses : UInt = 0
    var number : UInt32 = 0
    var gameOver = false
    let MAX_GUESSES : UInt = 8

    func consoleOut(text : String) {
        output.text = output.text + text
    }
    
    func generateNewNumber() -> UInt32 {
        return arc4random_uniform(100) + 1
    }
    
    func clearInput() {
        inputField.text = ""
    }

    
    
    @IBAction func guess(sender: UIButton) {
        if gameOver {
            var newGame = inputField.text

            if newGame == "Y" {
                gameOver = false
                output.text = ""
                clearInput()
                number = generateNewNumber()
                return
            }
        }
        var possibleGuess : Int? = inputField.text.toInt()
        if let guess = possibleGuess {
            if UInt32(guess) > number {
                consoleOut("\(guess): You guessed too high!\n")
                ++guesses
            } else if UInt32(guess) < number {
                consoleOut("\(guess): You guessed too low!\n")
                ++guesses
            } else {
                consoleOut("\n\(guess): You win!\n")
                consoleOut("Go again? (Y)")
                guesses = 0
                gameOver = true
            }
            clearInput()
            
            if (guesses == MAX_GUESSES) {
                var guessvalue = String(number);
                consoleOut("\n You lose !The Guessed value is"+guessvalue)
                consoleOut("\n Enter Y to continue")
                
                guesses = 0
                gameOver = true
            }
            
        } else {
            consoleOut("Please input a valid number!\n")
            clearInput()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        number = generateNewNumber()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

