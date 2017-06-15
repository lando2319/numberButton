//
//  ViewController.swift
//  numberButton
//
//  Created by MIKE LAND on 6/15/17.
//  Copyright © 2017 MIKE LAND. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBAction func buttonIsTapped(_ sender: Any) {
        let diceRoll = Int(arc4random_uniform(6) + 1)
        self.bottomLabel.text = "Your number is \(diceRoll)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let diceRoll = Int(arc4random_uniform(6) + 1)
        
        self.topLabel.numberOfLines = 0
        
        self.topLabel.text = "Tap Button, get a random number (1 - 6), see if your number is higher than \(diceRoll)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

