//
//  PlayGameViewController.swift
//  INTUIT
//
//  Created by KARTHIK on 5/31/15.
//  Copyright (c) 2015 Rizwan. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    @IBOutlet var inputfield: UITextField!

    @IBOutlet var output: UITextView!
    
    var guesses : UInt = 0
    var number : UInt32 = 0
    var gameOver = false
    var MAX_GUESSES : UInt = 8
    
    var randnumb :UInt32 = 0
    
    func consoleOut(text : String) {
        output.text = output.text + text
    }
    
    func generateNewNumber() -> UInt32 {
        return arc4random_uniform(100) + 1
    }
    
    func generateNewNumber1() -> UInt32 {
        return arc4random_uniform(1000) + 1
    }
    
    func clearInput(){
        
        inputfield.text=""
    }
    
   
    
    
    @IBAction func guess(sender: AnyObject) {
        
        if gameOver {
            var newGame = inputfield.text
            var randnumb1 = String(randnumb)
            if (newGame == randnumb1)
            {
                
                MAX_GUESSES  = MAX_GUESSES-2
                if(MAX_GUESSES==2){
                    var alertView = UIAlertView();
                    alertView.addButtonWithTitle("Ok");
                    alertView.title = "Winner";
                    alertView.message = "Congratulations! You beat the computer! You win!";
                    alertView.show();
                    
                    
                    
                }
                gameOver = false
                output.text = ""
                clearInput()
                number = generateNewNumber()
                return
            }
            
            if newGame=="S"{
                
                gameOver = false
                output.text = ""
                clearInput()
                number = generateNewNumber()
                return
            }
            
        }
        var possibleGuess : Int? = inputfield.text.toInt()
        if let guess = possibleGuess {
            if UInt32(guess) > number {
                consoleOut("\(guess): You guessed too high!\n")
                ++guesses
            } else if UInt32(guess) < number {
                consoleOut("\(guess): You guessed too low!\n")
                ++guesses
            } else {
                consoleOut("\n\(guess): You win!\n")
                
               randnumb = generateNewNumber1()
                consoleOut("Proceed to the next level? Enter the given level code: \(randnumb)")
                guesses = 0
                gameOver = true
            }
            clearInput()
            
            if (guesses == MAX_GUESSES) {
                var guessvalue = String(number);
                consoleOut("\n You lose !The Guessed value is"+guessvalue)
                consoleOut("\n Enter S to play again")
                
                guesses = 0
                gameOver = true
                
                
            }
            
        } else {
            consoleOut("Please input a valid number!\n")
            clearInput()
        }
        
        

        
    }
    
    func onTap() {
        self.inputfield.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        number = generateNewNumber()

        var tap = UITapGestureRecognizer(target: self, action: "onTap")
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
