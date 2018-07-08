//
//  ViewController.swift
//  calculator
//
//  Created by motoki-shun on 2018/05/10.
//  Copyright © 2018年 motoki-shun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // for hack sizeClass
    var isPortrait = false
    var traitCollectionCompactRegular  =  UITraitCollection()
    var traitCollectionAnyAny = UITraitCollection()

    let OperatorTypes = [
        "Null": 0,
        "DividedBy": 1,
        "Times": 2,
        "Minus": 3,
        "Plus": 4,
    ]

    var viewerNum:String = "0"
    var operand1:Double = 0
    var operand2:Double = 0
    var operatorType:Int = 0
    var isDot = false

    @IBOutlet weak var label: UILabel!

    @IBAction func btnNumbersOnClicked(_ sender: UIButton) {
        let dotStr:String = isDot ? "." : ""
        if !isCalculating() {
            let numStr = doubleToString(operand1)
            operand1 = Double(numStr + dotStr + String(sender.tag))!
            drawNum(operand1)
        }
        else {
            let numStr = doubleToString(operand2)
            operand2 = Double(numStr + dotStr + String(sender.tag))!
            drawNum(operand2)
        }
        isDot = false
    }

    @IBAction func btnOparatorOnClicked(_ sender: UIButton) {
        operatorType = sender.tag
    }

    @IBAction func btnClearOnClicked(_ sender: UIButton) {
        operand1 = 0
        operand2 = 0
        operatorType = 0
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
        let hasDot = regexpMatch(target: viewerNum, pattern: "\\.")
        if hasDot { return }
        viewerNum += "."
        label.text = viewerNum
        isDot = true
    }

    @IBAction func btnEqualOnClicked(_ sender: UIButton) {
        if !isCalculating() { return }
        let result = calc(operand1, operatorType, operand2)
        drawNum(result)
        operand1 = result
        operand2 = 0
        operatorType = 0
    }

    func doubleToString(_ num:Double) -> (String) {
        let str:String
        if num == floor(num) {
            str = String(format: "%.0f", num)
        }
        else {
            str = String(num)
        }
        return str
    }

    func drawNum(_ num: Double) {
        viewerNum = doubleToString(num)
        label.text = viewerNum
    }

    func isCalculating() -> (Bool) {
        return operatorType != OperatorTypes["Null"]
    }

    func calc(_ operand1: Double, _ operatorType: Int, _ operand2: Double) -> (Double) {
        // NSLog(String(operand1) + ", " + String(operatorType) + ", " + String(operand2))
        switch operatorType {
            case OperatorTypes["DividedBy"]: // Devide
                return operand1 / operand2
            case OperatorTypes["Times"]: // Multiply
                return operand1 * operand2
            case OperatorTypes["Minus"]: // Minus
                return operand1 - operand2
            case OperatorTypes["Plus"]: // Plus
                return operand1 + operand2
            default:
                return operand2;
        }
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
        self.setUpReferenceSizeClasses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    func setUpReferenceSizeClasses() {
        let traitCollectionHcompact = UITraitCollection.init(horizontalSizeClass: UIUserInterfaceSizeClass.compact)
        let traitCollectionVRegular = UITraitCollection.init(verticalSizeClass: UIUserInterfaceSizeClass.regular)
        self.traitCollectionCompactRegular = UITraitCollection.init(traitsFrom: [traitCollectionHcompact, traitCollectionVRegular])

        let traitCollectionHAny = UITraitCollection.init(horizontalSizeClass: UIUserInterfaceSizeClass.unspecified)
        let traitCollectionVAny = UITraitCollection.init(verticalSizeClass: UIUserInterfaceSizeClass.unspecified)
        self.traitCollectionAnyAny = UITraitCollection.init(traitsFrom: [traitCollectionHAny, traitCollectionVAny])

        self.isPortrait = self.view.frame.height > self.view.frame.width
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.isPortrait = size.height > size.width
    }

    override func overrideTraitCollection(forChildViewController childViewController: UIViewController) -> UITraitCollection? {
        let traitCollectionForOverride = self.isPortrait ? self.traitCollectionCompactRegular : self.traitCollectionAnyAny
        return traitCollectionForOverride
    }
}
