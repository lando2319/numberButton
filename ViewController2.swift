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
    @IBOutlet weak var dieRoll: UIImageView!
    
    var animImages: [UIImage] = [UIImage(named: "die1")!, UIImage(named: "die2")!,
                                 UIImage(named: "die3")!, UIImage(named: "die4")!,
                                 UIImage(named: "die5")!, UIImage(named: "die6")!,
                                 UIImage(named: "die1")!, UIImage(named: "die2")!,
                                 UIImage(named: "die3")!, UIImage(named: "die4")!,
                                 UIImage(named: "die5")!, UIImage(named: "die6")!,
                                 UIImage(named: "die1")!, UIImage(named: "die2")!,
                                 UIImage(named: "die3")!, UIImage(named: "die4")!,
                                 UIImage(named: "die5")!, UIImage(named: "die6")!]
    var recievedString = String()
    var strings: [String] = []
    var rolls: [Int] = []
    var average: Double = 0
    var win = true
    var bet = 0.0
    var roll = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        dieRoll.animationImages = animImages
        dieRoll.animationDuration = 1
        dieRoll.startAnimating()
        self.perform(#selector(ViewController2.afterAnimation), with: nil, afterDelay: dieRoll.animationDuration)
        
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
    
    func afterAnimation() {
        dieRoll.stopAnimating()
        dieRoll.image = animImages[roll-1]
        
        myLabel1.text = recievedString
        if win {
            resultLabel.text = "Congrats! You won $\(bet)0"
        }
        else {
            resultLabel.text = "Sorry, you lost $\(bet)0"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: ViewControllerTable = segue.destination as! ViewControllerTable
        newVC.recievedStrings.append(recievedString)
        newVC.recievedStrings = strings
        newVC.rolls.append(roll)
        newVC.rolls = rolls
        newVC.average = average
    }
}
