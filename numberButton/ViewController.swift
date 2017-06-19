//
//  ViewController.swift
//  numberButton
//
//  Created by MIKE LAND on 6/15/17.
//  Copyright © 2017 MIKE LAND. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    var strings: [String] = []
    var rolls: [Int] = []
    var options: [Double] = []
    
    var total = 0
    var count = 0
    var money = 100.0
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
        rolls.append(userRoll)
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
        moneyLabel.text = "You have $\(money)0"
        
        let diceRoll1 = Int(arc4random_uniform(6) + 1)
        compRoll = diceRoll1
        
        self.topLabel.text = "Roll the die, win your bet if you roll \(diceRoll1) or higher!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let formatted = String(format: "%.02f", money)
        moneyLabel.text = "You have $\(formatted)"
        let diceRoll = Int(arc4random_uniform(6) + 1)
        compRoll = diceRoll
        
        self.topLabel.numberOfLines = 0
        
        self.topLabel.text = "Roll the die, win your bet if you roll \(diceRoll) or higher!"
        
        for i in 1...Int(money) {
            options.append(Double(i))
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: ViewController2 = segue.destination as! ViewController2
        let passedPhrase = bottomLabel.text
        self.bottomLabel.text = ""
        newVC.recievedString = passedPhrase!
        newVC.strings = strings
        newVC.rolls = rolls
        newVC.average = Double(total) / Double(count)
        newVC.win = win
        newVC.bet = bet
        newVC.roll = userRoll
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
        let authenticationContext = LAContext()
        var error: NSError?
        
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            // Touch ID, navigating to success VC, handling errors
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use Touch ID to confirm bet", reply: { (success, error) in
                if success {
                    self.bet = self.options[row]
                }
                else {
                    if let error = error as NSError? {
                        //display an error
                        self.showAlertView(message: self.errorMessage(errorCode: error.code))
                    }
                    self.picker.selectRow(Int(self.bet)-1, inComponent: 0, animated: true)
                    return
                }
            })
        }
        else {
            createAlert(title: "No Touch ID", message: "This device does not support Touch ID.")
            return
        }
    }

    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertView(message: String){
        createAlert(title: "Error", message: message)
    }
    
    func errorMessage(errorCode: Int) -> String {
        var message = String()
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentcation was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "The passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentcation was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts"
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "Touch ID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
        
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
        }
        return message
    }
}

