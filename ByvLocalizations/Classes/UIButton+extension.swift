//
//  UIButton+extension.swift
//  ByvLocalizations
//
//  Created by Adrian Apodaca on 1/5/18.
//

import Foundation
import UIKit

extension UIButton {
    private(set) var formatTitle: ByvFormatLoc? {
        get {
            return objc_getAssociatedObject(self, &ByvFormatLoc.assKey) as? ByvFormatLoc
        }
        set {
            objc_setAssociatedObject(self, &ByvFormatLoc.assKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func observeLocChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.localizeText),
            name: ByvLocalizator.notiName,
            object: nil)
        self.localizeText()
    }
    
    public func locTitle(format: String, args:[CVarArg]? = nil, comment: String? = nil) {
        self.formatTitle = ByvFormatLoc(format: format, args: args, comment: comment)
        self.observeLocChanges()
    }
    
    public func setLocTitleArgs(_ newValue:[CVarArg]) {
        self.formatTitle?.args = newValue
        self.localizeText()
    }
    
    @objc func localizeText() {
        if let formatLoc = formatTitle {
            if let args = formatLoc.args {
                self.setTitle(String(format: formatLoc.format.localize(comment: formatLoc.comment), arguments: args), for: .normal)
            } else {
                self.setTitle(formatLoc.format.localize(comment: formatLoc.comment), for: .normal)
            }
        }
    }
}
