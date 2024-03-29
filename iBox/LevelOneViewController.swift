//
//  LevelOneViewController.swift
//  iBox
//
//  Created by ALEKSANDER ONISZCZAK on 2019-07-20.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit
import AVFoundation
//import AudioToolbox

extension String {
    var isDigits: Bool {
        guard !self.isEmpty else { return false }
        return !self.contains { Int(String($0)) == nil }
    }
}


class LevelOneViewController: UIViewController, UITextFieldDelegate{

    var bombSoundEffect: AVAudioPlayer?
    
    let number = Int.random(in: 1 ..< 10)
    
    let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var questionBox: UITextField!
    @IBOutlet weak var titleBox: UITextView!
    @IBOutlet weak var answerBox: UITextField!
    @IBOutlet weak var theButton: UIButton!
    
    @IBAction func pinkButton(_ sender: Any) {
        titleBox.textColor = UIColor.systemRed
    }
    
    @IBAction func purpleButton(_ sender: Any) {
        titleBox.textColor = UIColor.systemPurple
    }
    
    @IBAction func blueButton(_ sender: Any) {
        titleBox.textColor = UIColor.systemBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("The secret number is: \(number)")
        //print (number)
        print ("As emoji:")
//        print ()
        
        self.questionBox.delegate = self
        
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Enter", style: .plain, target: self, action: #selector(handleEnter))
        bar.items = [reset]
        bar.sizeToFit()
        titleBox.inputAccessoryView = bar

        questionBox.layer.borderWidth = 1
        questionBox.layer.borderColor = UIColor.systemOrange.cgColor
        
    }

    @objc func handleEnter(sender:UIButton) {
        self.titleBox.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
       
        // Check if nothing was entered
        guard var guessedNumberAsText = questionBox.text, !guessedNumberAsText.isEmpty else {
            answerBox.text = "It looked like you were about to say something..."
            return
        }
        
        // Check if guess is a number
        if !guessedNumberAsText.isDigits {
            answerBox.text = guessedNumberAsText + " is not a number silly."
            questionBox.text = ""
            return
        }
        
        var guessedNumber = Int(guessedNumberAsText)
        
        // Check if guess is greater than 10
        if guessedNumber! > 10 {
            answerBox.text = guessedNumberAsText + " is waaaaaay too high!"
            questionBox.text = ""
            return
        }
        
        // Check if guess is greater than 10
        if guessedNumber! == 0 {
            answerBox.text = guessedNumberAsText + " is my hero, but not in this game!"
            questionBox.text = ""
            return
        }
        
//        // Check if guess less than 0
//        if guessedNumber! < 0 {
//            answerBox.text = guessedNumberAsText + " is far too negative!"
//            questionBox.text = ""
//            return
//        }
        
        // Go to Next Level
        if theButton.titleLabel!.text != "Enter" {
            performSegue(withIdentifier: "goToLevel2TitlePage", sender: nil)
        }
        // Stay in the game and play sound
        else if String(number) != questionBox.text {
            // Play sound
            let path = Bundle.main.path(forResource: guessedNumberAsText+".mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                bombSoundEffect = try AVAudioPlayer(contentsOf: url)
                bombSoundEffect?.play()
            } catch {
                // couldn't load file :(
            }
        }
        
        // Correct Answer!
        if String(number) == questionBox.text  && theButton.titleLabel!.text == "Enter" {
            print ("YES!")
            answerBox.text = "YES!"
            
            AudioServicesPlaySystemSound(1519)
            
            let utterance = AVSpeechUtterance(string: questionBox.text! + "is correct. Yaaaaaaaaaaaay! You got it! You may now advance to level two.")
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
                    print("inside")
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
            }
            else {
                answerBox.text = answerBox.text! + ". Try a LOWER number."
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
                    print("inside")
                    v.removeFromSuperview()
                })
            }
        }
    }
}

