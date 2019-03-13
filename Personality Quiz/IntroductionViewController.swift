//
//  ViewController.swift
//  Personality Quiz
//
//  Created by student19 on 3/7/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // method that listens for a button press on "Done" button and dismisses the view controllers created after the IntroductionViewController was displayed
    @IBAction func unwindToQuizIntroduction(segue: UIStoryboardSegue) {
        
    }
    
}

