//
//  ViewController.swift
//  calculator
//
//  Created by motoki-shun on 2018/05/10.
//  Copyright © 2018年 motoki-shun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let OperatorTypes = [
        "Null": 0,
        "DividedBy": 1,
        "Times": 2,
        "Minus": 3,
        "Plus": 4,
    ]

    var viewerNum:String = "0"
    var currentNum:Double = 0
    var operand1:Double = 0
    var operand2:Double = 0
    var operatorType:Int = 0
    var isDot = false

    @IBOutlet weak var label: UILabel!

    @IBAction func btnNumbersOnClicked(_ sender: UIButton) {
         let dotStr:String = isDot ? "." : ""
        isDot = false
        if operatorType == OperatorTypes["Null"] {
            // let numStr = isDot ? String(format: "%.0f", operand1) : String(operand1)
            // operand1 = Double(label.text! + dotStr + String(sender.tag))!
            // operand1 = Double(viewerNum + dotStr + String(sender.tag))!
            operand1 = Double(viewerNum + String(sender.tag))!
            // operand1 = Double(label.text! + String(sender.tag))!
            NSLog(String(operand1))
            NSLog(viewerNum + String(sender.tag))
            // drawNum(operand1)
            drawNum(viewerNum + String(sender.tag))
        }
        else {
            // let numStr = isDot ? String(format: "%.0f", operand2) : String(operand2)
            // operand2 = Double(label.text! + dotStr + String(sender.tag))!
            // operand2 = Double(viewerNum + dotStr + String(sender.tag))!
            // operand2 = Double(viewerNum + String(sender.tag))!
            // operand2 = Double(label.text! + String(sender.tag))!
            let numStr = String(format: "%.0f", operand2)
            operand2 = Double(numStr + String(sender.tag))!
            drawNum(numStr + String(sender.tag))
        }
    }

    @IBAction func btnOparatorOnClicked(_ sender: UIButton) {
//        if sender.tag == OperatorTypes["DividedBy"] { // Devide
//            label.text = "/"
//        }
//        else if sender.tag == OperatorTypes["Times"] { // Multiply
//            label.text = "x"
//        }
//        else if sender.tag == OperatorTypes["Minus"] { // Minus
//            label.text = "-"
//        }
//        else if sender.tag == OperatorTypes["Plus"] { // Plus
//            label.text = "+"
//        }
        operatorType = sender.tag
    }

    @IBAction func btnClearOnClicked(_ sender: UIButton) {
        operand1 = 0
        operand2 = 0
        operatorType = 0
        viewerNum = "0"
        label.text = viewerNum
    }
    
    @IBAction func btnDotOnClicked(_ sender: UIButton) {
        let num = Double(viewerNum)!
        if num != floor(num) { return }
        viewerNum += "."
        label.text = viewerNum
        isDot = true
    }

    @IBAction func btnEqualOnClicked(_ sender: UIButton) {
        if operatorType == OperatorTypes["Null"] { return }
        let result = calc(operand1, operatorType, operand2)
        drawNum(String(result))
        operand1 = result
        operand2 = 0
        operatorType = 0
    }

    func drawNum(_ num: String) {
        if Double(num) == floor(Double(num)!) {
//            viewerNum = String(format: "%.0f", num)
            viewerNum = String(format: "%.0f", floor(Double(num)!))
        }
        else {
            viewerNum = String(num)
        }
        label.text = viewerNum
    }

    func calc(_ operand1: Double, _ operatorType: Int, _ operand2: Double) -> (Double) {
//        console.log(operand1, operatorType, operand2);
        switch operatorType {
            case OperatorTypes["DividedBy"]:
                return operand1 / operand2
            case OperatorTypes["Times"]:
                return operand1 * operand2
            case OperatorTypes["Minus"]:
                return operand1 - operand2
            case OperatorTypes["Plus"]:
                return operand1 + operand2
            default:
                return operand2;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

