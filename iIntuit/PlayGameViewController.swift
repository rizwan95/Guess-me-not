//
//  PlayGameViewController.swift
//  INTUIT
//
//  Created by KARTHIK on 5/31/15.
//  Copyright (c) 2015 Rizwan. All rights reserved.
//

import UIKit
import AVFoundation


class PlayGameViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate{
    @IBOutlet var inputfield: UITextField!

    @IBOutlet var output: UITextView!
    @IBOutlet weak var displaylabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet var chanceslabel: UILabel!
    
    var guesses : UInt = 0
    var number : UInt32 = 0
    var gameOver = false
    var scorevar : UInt = 0
    var MAX_GUESSES : UInt = 10
    var randnumb :UInt32 = 0
    var num : UInt32 = 20
    var backgroundMusic1 = AVAudioPlayer()
    var error = AVAudioPlayer()
    var nextlevel = AVAudioPlayer()
    var win = AVAudioPlayer()
    var gameoversound = AVAudioPlayer()
    var chancesvar : UInt = 0
    
    
    
    
    func consoleOut(text : String) {
        output.text = output.text + text
        output.textColor = UIColor.whiteColor()
        output.textAlignment = NSTextAlignment.Center
    }
    
    func generateNewNumber(num: UInt32) -> UInt32 {
        return arc4random_uniform(num) + 1
    }
    
    func generateNewNumber1() -> UInt32 {
        return arc4random_uniform(1000) + 1
    }
    
    func clearInput(){
        
        inputfield.text=""
    }
    func firstview(){
        let mainview = self.storyboard?.instantiateViewControllerWithIdentifier("mainview") as ViewController
        self.navigationController?.pushViewController(mainview, animated: true)
        win.stop()
    }
    
    func setupAudioPlayerWithFile1(file:NSString, type:NSString) -> AVAudioPlayer  {
        
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        
        var error: NSError?
        
        
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
       
        return audioPlayer!
    }
    
    
    
    func guessfunc() {
       
        
        if gameOver {
            var newGame = inputfield.text
            var randnumb1 = String(randnumb)
            if (newGame == randnumb1)
            {
                
                
                MAX_GUESSES  = MAX_GUESSES-1
                chancesvar = MAX_GUESSES
                chanceslabel.text = "\(chancesvar)"
                
                if( MAX_GUESSES == 5 ){
                    
                    win = self.setupAudioPlayerWithFile1("win", type:"mp3")
                    win.numberOfLoops = 0
                    win.play()
                    
                    
                    var alertController = UIAlertController(title: "Congratulations !", message: "You have successfully cleared all the levels !  You beat the computer !", preferredStyle: .Alert)
                    var okAction = UIAlertAction(title: "Main Menu", style: UIAlertActionStyle.Default) {
                        UIAlertAction in
                        self.firstview()}
                    alertController.addAction(okAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
                
                gameOver = false
                output.text = ""
                clearInput()
                num=num+20
                number = generateNewNumber(num)
                if(MAX_GUESSES == 5)
                {
                displaylabel.text = "Enter a number between 1 to 100"
                }
                
                else{
                
                displaylabel.text = "Enter a number between 1 to \(num)"
                }
                return
                
                
            }
            
            if newGame=="S"{
                
                chancesvar = MAX_GUESSES
                chanceslabel.text="\(chancesvar)"

                
                gameOver = false
                output.text = ""
                clearInput()
                number = generateNewNumber(num)

                return
            }
            
        }
        var possibleGuess : Int? = inputfield.text.toInt()
        if let guess = possibleGuess {
           
            if UInt32(guess) > number {
                consoleOut("\n Number guessed: \(guess). Guess too high.")
                ++guesses
                
                if (chancesvar == 0){
                    chanceslabel.text="0"
                    
                }
                    
                else{
                    
                    chancesvar = chancesvar - 1
                    chanceslabel.text="\(chancesvar)"
                }
                
                if guesses < MAX_GUESSES
                {
                    error = self.setupAudioPlayerWithFile1("error", type:"mp3")
                    error.numberOfLoops = 1
                    error.play()
                    
                    var alertView = UIAlertView();
                    alertView.addButtonWithTitle("Ok");
                    alertView.title = "Wrong guess"
                    alertView.message = "Your guess was high, try to guess a lower number. ";
                    alertView.show();
                    
                    
                    
                    }
            }
            
            else if UInt32(guess) < number {
                consoleOut("\n Number guessed: \(guess) . Guess too low. ")
                ++guesses
                
                
                if (chancesvar == 0){
                    chanceslabel.text="0"
                    
                }
                else
                {
                
                chancesvar = chancesvar - 1
                chanceslabel.text="\(chancesvar)"
                }
                
                if guesses < MAX_GUESSES
                {
                    
                    error = self.setupAudioPlayerWithFile1("error", type:"mp3")
                    error.numberOfLoops = 1
                    error.play()
                    
                    var alertView = UIAlertView();
                    alertView.addButtonWithTitle("Ok");
                    alertView.title = "Wrong guess";
                    alertView.message = "Your guess was low, try to guess a higher number. ";
                    alertView.show();
                    
                    
                    
                }
                
            } else {
                randnumb = generateNewNumber1()
                
                consoleOut("\n\(guess): You win!\n")
                consoleOut("Proceed to the next level? Enter the given level code: \(randnumb)")
                
                nextlevel = self.setupAudioPlayerWithFile1("nextlevel", type:"mp3")
                nextlevel.numberOfLoops = 0
                nextlevel.play()
                
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("Ok");
                alertView.title = "Correct guess !";
                alertView.message = "You would have beat me now! Next time you can't !  Enter the level code \(randnumb) to unlock the next level";
                alertView.show();
                scorevar = scorevar+20
                score.text="\(scorevar)"
                guesses = 0
                gameOver = true
            }
            clearInput()
            
            if (guesses == MAX_GUESSES) {
                var guessvalue = String(number);
                
                gameoversound = self.setupAudioPlayerWithFile1("gameover", type:"wav")
                gameoversound.numberOfLoops = 1
                gameoversound.play()
                
                consoleOut("\n You lose !The Guessed value is"+guessvalue)
                consoleOut("\n Enter S to play again")
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("Ok");
                alertView.title = "Game Over!";
                alertView.message = "You have used all of your chances ! You lose The Guessed value is \(guessvalue) ! Enter 'S' to play again";
                alertView.show();
                
                guesses = 0
                gameOver = true
                
                
            }
            
        } else {
            
            error = self.setupAudioPlayerWithFile1("error", type:"mp3")
            error.numberOfLoops = 1
            error.play()
            
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("Ok");
            alertView.title = "Invalid Input";
            alertView.message = "Please enter a valid number";
            alertView.show();
            
            clearInput()
        }
        
        inputfield.resignFirstResponder()
        
        

    }
    
    
    
    @IBAction func guess(sender: AnyObject) {
        self.guessfunc()
        
    }
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        self.guessfunc()
        return true;
    
    }
    
    
    
    func onTap() {
        self.inputfield.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number = generateNewNumber(num)
        chancesvar = MAX_GUESSES
        

        
        displaylabel.text = "Enter a number between 1 to \(num)"
        
        var tap = UITapGestureRecognizer(target: self, action: "onTap")
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
        inputfield.delegate = self
        
        
        backgroundMusic1 = self.setupAudioPlayerWithFile1("gameplay", type:"mp3")
        backgroundMusic1.numberOfLoops = -1
        backgroundMusic1.play()

        
        
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        backgroundMusic1.stop()
        
    }
    
    override func  viewWillAppear(animated: Bool) {
        backgroundMusic1 = self.setupAudioPlayerWithFile1("gameplay", type:"mp3")
        backgroundMusic1.numberOfLoops = -1
        backgroundMusic1.play()
    }

    
    
  

}

