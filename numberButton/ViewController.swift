//
//  ViewController.swift
//  numberButton
//
//  Created by MIKE LAND on 6/15/17.
//  Copyright © 2017 MIKE LAND. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    var strings: [String] = []
    let options: [Double] = [1,2,3,4,5,6,7,8,9,10]
    var total = 0
    var count = 0
    var money = 5.0
    var bet = 1.0
    var compRoll = 0
    var userRoll = 0
    var win = true
    @IBAction func buttonIsTapped(_ sender: Any) {
        if bet > money {
            createAlert(title: "Invalid Bet", message: "You cannot bet more money than you have.")
            return
        }
        let diceRoll = Int(arc4random_uniform(6) + 1)
        userRoll = diceRoll
        total += diceRoll
        count += 1
        self.bottomLabel.text = "Your number is \(diceRoll)"
        strings.append(self.bottomLabel.text!)
        if userRoll > compRoll {
            money += bet
            win = true
        }
        else {
            money -= bet
            win = false
        }
        moneyLabel.text = "You have $\(money)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let formatted = String(format: "%.02f", money)
        moneyLabel.text = "You have $\(formatted)"
        let diceRoll = Int(arc4random_uniform(6) + 1)
        compRoll = diceRoll
        
        self.topLabel.numberOfLines = 0
        
        self.topLabel.text = "Tap Button, get a random number (1 - 6), see if your number is higher than \(diceRoll)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: ViewController2 = segue.destination as! ViewController2
        let passedPhrase = bottomLabel.text
        newVC.recievedString = passedPhrase!
        newVC.strings = strings
        newVC.average = Double(total) / Double(count)
        newVC.win = win
        newVC.bet = bet
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if money >= 10 {
            return options.count
        }
        else {
            return Int(money)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "$\(options[row])0"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bet = options[row]
    }

    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

