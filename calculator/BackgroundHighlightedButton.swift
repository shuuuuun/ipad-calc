//
//  BackgroundHighlightedButton.swift
//  calculator
//
//  Created by motoki-shun on 2018/07/20.
//  Copyright © 2018年 motoki-shun. All rights reserved.
//

import Foundation
import UIKit

final class BackgroundHighlightedButton: UIButton {
    @IBInspectable var highlightedBackgroundColor :UIColor?
    @IBInspectable var nonHighlightedBackgroundColor :UIColor?
    override var isHighlighted :Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = highlightedBackgroundColor
            }
            else {
                self.backgroundColor = nonHighlightedBackgroundColor
            }
        }
    }
}
