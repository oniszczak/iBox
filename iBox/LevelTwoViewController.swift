//
//  LevelTwoViewController.swift
//  iBox
//
//  Created by ALEKSANDER ONISZCZAK on 2019-09-04.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit
import AVFoundation

class LevelTwoViewController: UIViewController, UITextFieldDelegate {
    
    var bombSoundEffect: AVAudioPlayer?
    let number = Int.random(in: 1 ..< 50)
    
    let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var questionBox: UITextField!
    @IBOutlet weak var answerBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print ("The secret number is: \(number)")
        
        self.questionBox.delegate = self
        
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Enter", style: .plain, target: self, action: #selector(handleEnter))
        bar.items = [reset]
        bar.sizeToFit()
        
        questionBox.layer.borderWidth = 1
        questionBox.layer.borderColor = UIColor.systemOrange.cgColor
    }
    
    @objc func handleEnter(sender:UIButton) {
        //self.titleBox.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func pinkButtonPressed(_ sender: Any) {
        self.view.backgroundColor = UIColor.systemPink
    }
    
    @IBAction func indigoButoonPressed(_ sender: Any) {
        self.view.backgroundColor = UIColor.systemGreen
    }
    
    @IBAction func orangeButtonPressed(_ sender: Any) {
        self.view.backgroundColor = UIColor.systemOrange
    }
    
    @IBAction func donePressed(_ sender: Any) {
        // Check if nothing was entered
        guard var guessedNumberAsText = questionBox.text, !guessedNumberAsText.isEmpty else {
            answerBox.text = "It looked like you were about to say something..."
            let utterance = AVSpeechUtterance(string: answerBox.text!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.1

            //let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
            return
        }
        
        // Check if guess is a number
        if !guessedNumberAsText.isDigits {
            answerBox.text = guessedNumberAsText + " is not a number silly."
            let utterance = AVSpeechUtterance(string: answerBox.text!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.1

            //let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
            questionBox.text = ""
            return
        }
        
        var guessedNumber = Int(guessedNumberAsText)
        
        // Go to Next Level
        if theButton.titleLabel!.text != "Enter" {
            performSegue(withIdentifier: "goToLevel3TitlePage", sender: nil)
            return
        }
        // Stay in the game and play sound
        else {
            // Play sound
//            let utterance = AVSpeechUtterance(string: guessedNumberAsText)
//            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
//            utterance.rate = 0.1
//
//            let synthesizer = AVSpeechSynthesizer()
//            synthesizer.speak(utterance)
        }
        
        // Correct Answer!
        if String(number) == questionBox.text  && theButton.titleLabel!.text == "Enter" {
            print ("YES!")
            answerBox.text = "YES!"
            
            AudioServicesPlaySystemSound(1519)
            
            let utterance = AVSpeechUtterance(string: "You win! Good for you. Advance to the next level.")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.1

            //let synthesizer = AVSpeechSynthesizer()
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
            
            theButton.setTitle("Go To Next Level!", for: .normal)
        }
        // Wrong Guess
        else {
            print ("Nope!")
            answerBox.text = "Nope! It's not " + questionBox.text!
            questionBox.text = ""
            
            if guessedNumber! < number {
                answerBox.text = answerBox.text! + ". Try a HIGHER number."
                let utterance = AVSpeechUtterance(string: answerBox.text!)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                utterance.rate = 0.1

                //let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
            }
            else {
                answerBox.text = answerBox.text! + ". Try a LOWER number."
                let utterance = AVSpeechUtterance(string: answerBox.text!)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                utterance.rate = 0.1

                //let synthesizer = AVSpeechSynthesizer()
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
