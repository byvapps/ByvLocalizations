//
//  UIBarItem+extension.swift
//  ByvLocalizations
//
//  Created by Adrian Apodaca on 1/5/18.
//

import Foundation

extension UIBarItem {
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
    
    public var locTitle: String? {
        get {
            return formatTitle?.format
        }
        set {
            if let newValue = newValue {
                if self.formatTitle == nil {
                    self.formatTitle = ByvFormatLoc(format: newValue)
                } else {
                    self.formatTitle?.format = newValue
                }
                self.observeLocChanges()
            } else {
                self.formatTitle = nil
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
    
    public func locTitleFormat(format: String, args:[CVarArg]? = nil) {
        self.formatTitle = ByvFormatLoc(format: format, args: args)
        self.observeLocChanges()
    }
    
    public func setLocTitleArgs(_ newValue:[CVarArg]) {
        self.formatTitle?.args = newValue
        self.localizeText()
    }
    
    @objc func localizeText() {
        if let formatLoc = formatTitle {
            if let args = formatLoc.args {
                self.title = String(format: formatLoc.format.localize(), arguments: args)
            } else {
                self.title = formatLoc.format.localize()
            }
        }
    }
}
