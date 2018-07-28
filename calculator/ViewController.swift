//
//  ViewController.swift
//  calculator
//
//  Created by motoki-shun on 2018/05/10.
//  Copyright © 2018年 motoki-shun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum OperatorTypes: Int {
        case none
        case dividedBy
        case times
        case minus
        case plus
    }
    var viewerNum:String = "0"
    var operand1:Double = 0
    var operand2:Double = 0
    var operatorType:Int = 0
    var lastOperand2:Double = 0
    var lastOperatorType:Int = 0

    @IBOutlet weak var label: UILabel!

    @IBAction func btnNumbersOnClicked(_ sender: UIButton) {
        let clickedNumStr = String(sender.tag)
        if !isCalculating() {
            if hasExponent(String(operand1)) { return }
            let isZero = operand1 == 0
            let currentNumStr = hasDotInViewer() ? viewerNum : (isZero ? "" : doubleToString(operand1))
            let numStr = currentNumStr + clickedNumStr
            operand1 = Double(numStr)!
            viewerNum = numStr
        }
        else {
            if hasExponent(String(operand2)) { return }
            let isShowingOperand1 = operand1 == Double(viewerNum)!
            let isZero = operand2 == 0
            let currentNumStr = !isShowingOperand1 && hasDotInViewer() ? viewerNum : (isZero ? "" : doubleToString(operand2))
            let numStr = currentNumStr + clickedNumStr
            operand2 = Double(numStr)!
            viewerNum = numStr
        }
        label.text = viewerNum
//        NSLog("operand1:" + String(operand1) + ", operand2:" + String(operand2) + ", viewerNum:" + String(viewerNum))
//        NSLog("operand1:\(operand1), operand2:\(operand2), viewerNum:\(viewerNum)")
    }

    @IBAction func btnOparatorOnClicked(_ sender: UIButton) {
        if isCalculating() {
            doCalc()
        }
        operatorType = sender.tag
    }

    @IBAction func btnClearOnClicked(_ sender: UIButton) {
        operand1 = 0
        operand2 = 0
        operatorType = 0
        lastOperand2 = 0
        lastOperatorType = 0
        viewerNum = "0"
        label.text = viewerNum
    }

    @IBAction func btnSignOnClicked(_ sender: UIButton) {
        if !isCalculating() {
            operand1 *= -1
            drawNum(operand1)
        }
        else {
            operand2 *= -1
            drawNum(operand2)
        }
    }

    @IBAction func btnPercentOnClicked(_ sender: UIButton) {
        if !isCalculating() {
            operand1 /= 100
            drawNum(operand1)
        }
        else {
            operand2 /= 100
            drawNum(operand2)
        }
    }

    @IBAction func btnDotOnClicked(_ sender: UIButton) {
        if hasDotInViewer() { return }
        viewerNum += "."
        label.text = viewerNum
    }

    @IBAction func btnEqualOnClicked(_ sender: UIButton) {
        if isCalculating() {
            doCalc()
        }
        else {
            // repeat equal
            if lastOperatorType != OperatorTypes.none.rawValue {
                let result = calc(operand1, lastOperatorType, lastOperand2)
                drawNum(result)
                operand1 = result
            }
        }
    }

    func doubleToString(_ num:Double) -> (String) {
        let str:String
        if hasExponent(String(num)) {
            str = String(num)
        }
        else if num == floor(num) {
            str = String(format: "%.0f", num)
        }
        else {
            str = String(num)
        }
//        NSLog("doubleToString: \(num), \(str), \(hasExponent(String(num)))")
        return str
    }

    func drawNum(_ num: Double) {
        viewerNum = doubleToString(num)
        label.text = viewerNum
    }

    func isCalculating() -> (Bool) {
        return operatorType != OperatorTypes.none.rawValue
    }

    func doCalc() {
        let result = calc(operand1, operatorType, operand2)
        drawNum(result)
        lastOperand2 = operand2
        lastOperatorType = operatorType
        operand1 = result
        operand2 = 0
        operatorType = 0
    }

    func calc(_ operand1: Double, _ operatorType: Int, _ operand2: Double) -> (Double) {
        // NSLog(String(operand1) + ", " + String(operatorType) + ", " + String(operand2))
        switch operatorType {
            case OperatorTypes.dividedBy.rawValue:
                return operand1 / operand2
            case OperatorTypes.times.rawValue:
                return operand1 * operand2
            case OperatorTypes.minus.rawValue:
                return operand1 - operand2
            case OperatorTypes.plus.rawValue:
                return operand1 + operand2
            default:
                return operand2
        }
    }

    func hasExponent(_ target: String) -> Bool {
        return regexpMatch(target: target, pattern: "e")
    }

    func hasDotInViewer() -> Bool {
        return regexpMatch(target: viewerNum, pattern: "\\.")
    }

    func regexpMatch(target: String, pattern: String, options: NSRegularExpression.Options = []) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return false
        }
        let matches = regex.matches(in: target, options: [], range: NSMakeRange(0, target.count))
        return matches.count > 0
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
