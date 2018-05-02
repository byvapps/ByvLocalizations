//
//  UILabel+extension.swift
//  ByvLocalizations_Example
//
//  Created by Adrian Apodaca on 1/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension UILabel {
    
    private(set) var formatText: ByvFormatLoc? {
        get {
            return objc_getAssociatedObject(self, &ByvFormatLoc.assKey) as? ByvFormatLoc
        }
        set {
            objc_setAssociatedObject(self, &ByvFormatLoc.assKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func observeLocChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.localizeText),
            name: ByvLocalizator.notiName,
            object: nil)
        self.localizeText()
    }
    
    public func locText(_ format: String, args:[CVarArg]? = nil, comment: String? = nil) {
        self.formatText = ByvFormatLoc(format: format, args: args, comment: comment)
        self.observeLocChanges()
    }
    
    public func setLocArgs(_ newValue:[CVarArg]) {
        self.formatText?.args = newValue
        self.localizeText()
    }
    
    @objc func localizeText() {
        if let formatLoc = formatText {
            if let args = formatLoc.args {
                self.text = String(format: formatLoc.format.localize(comment: formatLoc.comment), arguments: args)
            } else {
                self.text = formatLoc.format.localize(comment: formatLoc.comment)
            }
            self.superview?.layoutSubviews()
        }
    }
}
