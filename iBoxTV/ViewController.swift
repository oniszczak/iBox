//
//  ViewController.swift
//  iBoxTV
//
//  Created by ALEKSANDER ONISZCZAK on 2019-10-24.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var answerBox: UITextField!
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var segmentedNumbers: UISegmentedControl!
    @IBOutlet weak var pickLabel: UILabel!
    
    var bombSoundEffect: AVAudioPlayer?
    let number = Int.random(in: 1 ..< 10)
    var guessedNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("The secret number is: \(number)")
        
    }

    @IBAction func pinkPressed(_ sender: Any) {
        self.view.backgroundColor = UIColor.systemPink
    }
    
    @IBAction func greenPressed(_ sender: Any) {
        self.view.backgroundColor = UIColor.systemGreen
    }
    
    @IBAction func orangePressed(_ sender: Any) {
        self.view.backgroundColor = UIColor.systemOrange
    }
    
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedNumbers.selectedSegmentIndex {
             
        case 0:
            guessedNumber = 1
        case 1:
            guessedNumber = 2
        case 2:
            guessedNumber = 3
        case 3:
            guessedNumber = 4
        case 4:
            guessedNumber = 5
        case 5:
            guessedNumber = 6
        case 6:
            guessedNumber = 7
        case 7:
            guessedNumber = 8
        case 8:
            guessedNumber = 9
        case 9:
            guessedNumber = 10
        default:
            ()
             
        }
    }
    
    @IBAction func guessPressed(_ sender: Any) {
        if number == guessedNumber {
            print ("YES!")
            answerBox.text = "YES!"
            
            let utterance = AVSpeechUtterance(string: "You win! Good for you. You should play again.")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.1

            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
            
            // Flash Screen Green
            if let wnd = self.view{
                
                var v = UIView(frame: wnd.bounds)
                v.backgroundColor = UIColor.systemGreen
                v.alpha = 1
                
                wnd.addSubview(v)
                UIView.animate(withDuration: 2, animations: {
                    v.alpha = 0.0
                }, completion: {(finished:Bool) in
                    
                    v.removeFromSuperview()
                })
            }
            
            let seconds = 4.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                // Put your code which should be executed with a delay here
            }
            
            theButton.setTitle("Play Again!", for: .normal)
        }
        // Wrong Guess
        else {
            print ("Nope!")
            answerBox.text = "Nope! It's not " + String (guessedNumber)
            //questionBox.text = ""
            
            if guessedNumber < number {
                answerBox.text = answerBox.text! + ". Try a HIGHER number."
                let utterance = AVSpeechUtterance(string: answerBox.text!)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                utterance.rate = 0.1

                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
            }
            else {
                answerBox.text = answerBox.text! + ". Try a LOWER number."
                let utterance = AVSpeechUtterance(string: answerBox.text!)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                utterance.rate = 0.1

                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
            }
            
            // Flash Screen Red
            if let wnd = self.view{
                
                var v = UIView(frame: wnd.bounds)
                v.backgroundColor = UIColor.red
                v.alpha = 1
                
                wnd.addSubview(v)
                UIView.animate(withDuration: 1, animations: {
                    v.alpha = 0.0
                }, completion: {(finished:Bool) in
                    
                    v.removeFromSuperview()
                })
            }
        }
        
    }
    
    
}

