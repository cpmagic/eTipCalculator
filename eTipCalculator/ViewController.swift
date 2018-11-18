//
//  ViewController.swift
//  TipCalc
//
//  Created by Thomas Hill on 10/12/18.
//  Copyright © 2018 Computer Magic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    var percent = 15 {
        didSet {
            lblPercent.text = "\(percent)%"
            }
        }
    var people = 1 {
        didSet {
            lblPeople.text = "\(people)"
        }
    }
    var total = 0.00
    var splitTotal = 0.00
    
    @IBOutlet weak var txtCheckAmount: UITextField!
    @IBOutlet weak var lblTipResult: UILabel!
    @IBOutlet weak var lblTotalResult: UILabel!
    @IBOutlet weak var lblPercent: UILabel!
    @IBOutlet weak var lblPeople: UILabel!
    @IBOutlet weak var lblSplitTotal: UILabel!
    @IBOutlet weak var lblButtonRound: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUI()
    }
    @IBAction func btnClear(_ sender: UIButton) {
        resetUI()
    }
    @IBAction func percentMinus(_ sender: UIButton) {
        if percent == 1 {
            percent = 1
            percentChange(percent: percent)
        }
        else {
            percent -= 1
            percentChange(percent: percent)
        }
    }
    @IBAction func percentPlus(_ sender: UIButton) {
        if percent == 100 {
            percent = 100
            percentChange(percent: percent)
        }
        else {
            percent += 1
            percentChange(percent: percent)
        }
    }
    @IBAction func peopleMinus(_ sender: UIButton) {
        if people == 1 {
            people = 1
            peopleChange(people: people)
        }
        else {
            people -= 1
            peopleChange(people: people)
        }
    }
    @IBAction func peoplePlus(_ sender: UIButton) {
        people += 1
        peopleChange(people: people)
    }
    func percentChange(percent: Int) {
        let y: Float = Float(percent) / 100
        let z = Float(people)
        if let amount = txtCheckAmount.text {
            if let amountAsNumber = Float(amount) {
                let tip = amountAsNumber * y
                lblTipResult.text = String(format: "Tip: $%.02f", tip)
                let total = amountAsNumber + tip
                let splitTotal = (amountAsNumber / z) + (tip / z)
                if people == 1 {
                    lblTotalResult.text = String(format: "Pay: $%.02f", total)
                    lblSplitTotal.isHidden = true
                }
                else {
                    lblTotalResult.text = String(format: "Pay: $%.02f", total)
                    lblSplitTotal.isHidden = false
                    lblSplitTotal.text = String(format: "$%.02f Each", splitTotal)
                }
                
            }
        }
    }
    func peopleChange(people: Int) {
        percentChange(percent: percent)
        let y: Float = Float(people)
        let z = Float(percent) / 100
        if let amount = txtCheckAmount.text {
            if let amountAsNumber = Float(amount) {
                let tip = amountAsNumber * z
                lblTipResult.text = String(format: "Tip: $%.02f", tip)
                let total = amountAsNumber + tip
                let splitTotal = (amountAsNumber / y) + (tip / y)
                if people == 1 {
                    lblTotalResult.text = String(format: "Pay: $%.02f", total)
                    lblSplitTotal.isHidden = true
                }
                else {
                    lblTotalResult.text = String(format: "Pay: $%.02f", total)
                    lblSplitTotal.isHidden = false
                    lblSplitTotal.text = String(format: "$%.02f Each", splitTotal)
                }
            }
        }
    }
    @IBAction func textFieldChanged(_ sender: UITextField) {
        percentChange(percent: percent)
        peopleChange(people: people)
    }
    @IBAction func txtEditingDidChange(_ sender: UITextField) {
        percentChange(percent: percent)
        peopleChange(people: people)
    }
    func resetUI() {
        txtCheckAmount.becomeFirstResponder()
        people = 1
        percent = 15
        txtCheckAmount.text = ""
        lblPercent.text = "\(percent)%"
        lblPeople.text = "1"
        lblTipResult.text = "Tip:"
        lblTotalResult.text = "Pay:"
        lblSplitTotal.isHidden = true
        //lblButtonRound.isHidden = true
    }
}
