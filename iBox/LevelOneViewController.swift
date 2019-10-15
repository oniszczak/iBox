//
//  LevelOneViewController.swift
//  iBox
//
//  Created by ALEKSANDER ONISZCZAK on 2019-07-20.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
    var isDigits: Bool {
        guard !self.isEmpty else { return false }
        return !self.contains { Int(String($0)) == nil }
    }
}


class LevelOneViewController: UIViewController, UITextFieldDelegate{

    var bombSoundEffect: AVAudioPlayer?
    
    let number = Int.random(in: 1 ..< 10)
    
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
        
        self.questionBox.delegate = self
        
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
        bar.items = [reset]
        bar.sizeToFit()
        titleBox.inputAccessoryView = bar

        questionBox.layer.borderWidth = 1
        questionBox.layer.borderColor = UIColor.systemOrange.cgColor
        
    }

    @objc func handleDone(sender:UIButton) {
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
        
        // Go to Next Level
        if theButton.titleLabel!.text != "Done" {
            performSegue(withIdentifier: "goToLevel2TitlePage", sender: nil)
        }
        // Stay in the game and play sound
        else {
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
        if String(number) == questionBox.text  {
            print ("YES!")
            answerBox.text = "YES!"
            
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

