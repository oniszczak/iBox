//
//  ViewController.swift
//  iBox
//
//  Created by ALEKSANDER ONISZCZAK on 2019-07-20.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        // Do any additional setup after loading the view.
    }


}

