//
//  Level2TitlePageViewController.swift
//  iBox
//
//  Created by ALEKSANDER ONISZCZAK on 2019-09-08.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import UIKit

class LevelTwoTitlePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.performSegue(withIdentifier: "goToLevel2", sender: nil)
        }
        
    }
    
}
