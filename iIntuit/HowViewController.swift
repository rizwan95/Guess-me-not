//
//  HowViewController.swift
//  iIntuit
//
//  Created by KARTHIK on 6/16/15.
//  Copyright (c) 2015 rizwan. All rights reserved.
//

import UIKit
import AVFoundation

class HowViewController: UIViewController {

    var backgroundMusic = AVAudioPlayer()
    
    
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        
        var error: NSError?
        
        
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        
        return audioPlayer!
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        backgroundMusic = self.setupAudioPlayerWithFile("gamemain", type:"mp3")
        backgroundMusic.numberOfLoops = -1
        backgroundMusic.play()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        backgroundMusic.stop()
        
    }
    
    override func  viewWillAppear(animated: Bool) {
        //  backgroundMusic = self.setupAudioPlayerWithFile("gamemain", type:"mp3")
        // backgroundMusic.numberOfLoops = -1
        backgroundMusic.play()
        
        
    }


}
