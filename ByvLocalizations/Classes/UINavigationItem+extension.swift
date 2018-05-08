//
//  UINavigationItem+extension.swift
//  ByvLocalizations
//
//  Created by Adrian Apodaca on 1/5/18.
//

import Foundation

public extension UINavigationItem {
    public var formatTitle: ByvFormatLoc? {
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
    
    public func locTitle(_ format: String, args:[CVarArg]? = nil, comment: String? = nil) {
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
                self.title = String(format: formatLoc.format.localize(comment: formatLoc.comment), arguments: args)
            } else {
                self.title = formatLoc.format.localize(comment: formatLoc.comment)
            }
        }
    }
}
