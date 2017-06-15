//
//  ViewController2.swift
//  numberButton
//
//  Created by Leigh Rubin on 6/15/17.
//  Copyright © 2017 MIKE LAND. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    var recievedString = String()
    var strings: [String] = []
    var average: Double = 0
    var win = true
    var bet = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel1.text = recievedString
        if win {
            resultLabel.text = "Congrats! You won $\(bet)0"
        }
        else {
            resultLabel.text = "Sorry, you lost $\(bet)0"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: ViewControllerTable = segue.destination as! ViewControllerTable
        newVC.recievedStrings.append(recievedString)
        newVC.recievedStrings = strings
        newVC.average = average
    }
}
