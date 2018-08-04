//
//  ViewController.swift
//  calculator
//
//  Created by motoki-shun on 2018/05/10.
//  Copyright © 2018年 motoki-shun. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    enum OperatorType: Int {
        case none
        case dividedBy
        case times
        case minus
        case plus
    }
    var viewerNum: String = "0"
    var operand1: Double = 0
    var operand2: Double = 0
    var operatorType: OperatorType = .none
    var lastOperand2: Double = 0
    var lastOperatorType: OperatorType = .none

    @IBOutlet weak var label: UILabel!

    @IBAction func btnNumbersOnClicked(_ sender: UIButton) {
        let clickedNumStr = String(sender.tag)
        if !isCalculating() {
            if hasExponent(target: String(operand1)) { return }
            let isZero = operand1 == 0
            let currentNumStr = hasDotInViewer() ? viewerNum : (isZero ? "" : doubleToString(num: operand1))
            let numStr = currentNumStr + clickedNumStr
            if let unwrapped = Double(numStr) {
                operand1 = unwrapped
            }
            else {
                operand1 = 0
            }
            viewerNum = numStr
        }
        else {
            if hasExponent(target: String(operand2)) { return }
            var isShowingOperand1: Bool = false
            if let unwrapped = Double(viewerNum) {
                isShowingOperand1 = operand1 == unwrapped
            }
            let isZero = operand2 == 0
            let currentNumStr = !isShowingOperand1 && hasDotInViewer() ? viewerNum : (isZero ? "" : doubleToString(num: operand2))
            let numStr = currentNumStr + clickedNumStr
            if let unwrapped = Double(numStr) {
                operand2 = unwrapped
            }
            else {
                operand2 = 0
            }
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
        operatorType = OperatorType(rawValue: sender.tag) ?? .none
    }

    @IBAction func btnClearOnClicked(_ sender: UIButton) {
        operand1 = 0
        operand2 = 0
        operatorType = .none
        lastOperand2 = 0
        lastOperatorType = .none
        viewerNum = "0"
        label.text = viewerNum
    }

    @IBAction func btnSignOnClicked(_ sender: UIButton) {
        if !isCalculating() {
            operand1 *= -1
            drawNum(num: operand1)
        }
        else {
            operand2 *= -1
            drawNum(num: operand2)
        }
    }

    @IBAction func btnPercentOnClicked(_ sender: UIButton) {
        if !isCalculating() {
            operand1 /= 100
            drawNum(num: operand1)
        }
        else {
            operand2 /= 100
            drawNum(num: operand2)
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
            if lastOperatorType != .none {
                let result = calc(operand1: operand1, operatorType: lastOperatorType, operand2: lastOperand2)
                drawNum(num: result)
                operand1 = result
            }
        }
    }

    private func doubleToString(num: Double) -> String {
        let str: String
        if hasExponent(target: String(num)) {
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

    private func drawNum(num: Double) {
        viewerNum = doubleToString(num: num)
        label.text = viewerNum
    }

    private func isCalculating() -> Bool {
        return operatorType != .none
    }

    private func doCalc() {
        let result = calc(operand1: operand1, operatorType: operatorType, operand2: operand2)
        drawNum(num: result)
        lastOperand2 = operand2
        lastOperatorType = operatorType
        operand1 = result
        operand2 = 0
        operatorType = .none
    }

    private func calc(operand1: Double, operatorType: OperatorType, operand2: Double) -> Double {
        // NSLog(String(operand1) + ", " + String(operatorType) + ", " + String(operand2))
        switch operatorType {
            case .dividedBy:
                return operand1 / operand2
            case .times:
                return operand1 * operand2
            case .minus:
                return operand1 - operand2
            case .plus:
                return operand1 + operand2
            case .none:
                return operand2
        }
    }

    private func hasExponent(target: String) -> Bool {
        return regexpMatch(target: target, pattern: "e")
    }

    private func hasDotInViewer() -> Bool {
        return regexpMatch(target: viewerNum, pattern: "\\.")
    }

    private func regexpMatch(target: String, pattern: String, options: NSRegularExpression.Options = []) -> Bool {
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
