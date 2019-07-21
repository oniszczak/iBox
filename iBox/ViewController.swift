//
//  ViewController.swift
//  iBox
//
//  Created by ALEKSANDER ONISZCZAK on 2019-07-20.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit

extension UITextView {
    
//    func addDoneButton() {
//        let keyboardToolbar = UIToolbar()
//        keyboardToolbar.sizeToFit()
//        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                            target: nil, action: nil)
//        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
//                                            target: self, action: #selector(UIView.endEditing(_:)))
//        keyboardToolbar.items = [flexBarButton, doneBarButton]
//        self.inputAccessoryView = keyboardToolbar
//    }
}

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var questionBox: UITextField!
    @IBOutlet weak var titleBox: UITextView!
    
    @IBAction func pinkButton(_ sender: Any) {
        titleBox.textColor = UIColor.red
    }
    
    @IBAction func purpleButton(_ sender: Any) {
        titleBox.textColor = UIColor.purple
    }
    
    @IBAction func blueButton(_ sender: Any) {
        titleBox.textColor = UIColor.blue
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionBox.delegate = self
        
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
        bar.items = [reset]
        bar.sizeToFit()
        titleBox.inputAccessoryView = bar

    }

    @objc func handleDone(sender:UIButton) {
        self.titleBox.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

