//
//  LevelOneTitlePageViewController.swift
//  iBox
//
//  Created by ALEKSANDER ONISZCZAK on 2019-09-08.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit
import AVFoundation

class LevelOneTitlePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let seconds = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            self.performSegue(withIdentifier: "goToLevel1", sender: nil)
        }
        
    }
    
}
