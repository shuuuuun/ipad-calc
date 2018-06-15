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
    
//    var numberOnScreen:Double = 0
//    var previousNumber:Double = 0
//    var performingMath = false
//    var operation = 0

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
            operand1 = Double(label.text! + dotStr + String(sender.tag))!
            let floorNum = floor(operand1)
            // if abs(operand1.truncatingRemainder(dividingBy: 1.0)).isLess(than: .ulpOfOne) {
            if operand1 == floorNum {
                viewerNum = String(format: "%.0f", operand1)
            }
            else {
                viewerNum = String(operand1)
            }
            label.text = viewerNum
//            label.text = String(operand1)
//            label.text = String(format: "%.1f", operand1)
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .decimal
//            formatter.maximumFractionDigits = 2
//            formatter.positiveFormat = "0.##" // "0.##" -> 0パディングしない
//            var str:String = formatter.string(from: NSNumber(operand1))!
//            label.text = str
        }
//        if performingMath == true {
//            label.text = String(sender.tag-1)
//            numberOnScreen = Double(label.text!)!
//            performingMath = false
//        }
//        else {
//            label.text = label.text! + String(sender.tag-1)
//            numberOnScreen = Double(label.text!)!
//        }
    }

    @IBAction func btnOparatorOnClicked(_ sender: UIButton) {
        if sender.tag == OperatorTypes["DividedBy"] { // Devide
            label.text = "/"
        }
        else if sender.tag == OperatorTypes["Times"] { // Multiply
            label.text = "x"
        }
        else if sender.tag == OperatorTypes["Minus"] { // Minus
            label.text = "-"
        }
        else if sender.tag == OperatorTypes["Plus"] { // Plus
            label.text = "+"
        }
        operatorType = sender.tag
//        if label.text != "" {
//            previousNumber = Double(label.text!)!
//            operation = sender.tag
//            performingMath = true
//        }
    }

    @IBAction func btnClearOnClicked(_ sender: UIButton) {
        label.text = "0"
//        previousNumber = 0
//        numberOnScreen = 0
//        operation = 0
    }
    
    @IBAction func btnEqualOnClicked(_ sender: UIButton) {
        if operatorType == OperatorTypes["Null"] { return }
        let result = calc(operand1, operatorType, operand2)
        viewerNum = String(result)
        operand1 = result
        operand2 = 0
        operatorType = 0
        label.text = viewerNum

//        if operation == 12 {
//            label.text = String(previousNumber / numberOnScreen)
//        }
//        else if operation == 12 {
//            label.text = String(previousNumber * numberOnScreen)
//        }
//        else if operation == 12 {
//            label.text = String(previousNumber - numberOnScreen)
//        }
//        else if operation == 12 {
//            label.text = String(previousNumber + numberOnScreen)
//        }
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

