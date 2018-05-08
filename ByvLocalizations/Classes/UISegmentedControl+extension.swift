//
//  UISegmentedControl+extension.swift
//  ByvLocalizations
//
//  Created by Adrian Apodaca on 1/5/18.
//

import Foundation

public extension UISegmentedControl {
    public var formatTitles: [Int: ByvFormatLoc] {
        get {
            return objc_getAssociatedObject(self, &ByvFormatLoc.assKey) as? [Int: ByvFormatLoc] ?? [:]
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
    
    public func locTitle(_ format: String, args:[CVarArg]? = nil, at segment:Int, comment: String? = nil) {
        var titles = self.formatTitles
        titles[segment] = ByvFormatLoc(format: format, args: args, comment: comment)
        self.formatTitles = titles
        self.observeLocChanges()
    }
    
    @objc func localizeText() {
        let keys = self.formatTitles.keys
        for key in keys {
            if let formatLoc = self.formatTitles[key] {
                var str = formatLoc.format.localize(comment: formatLoc.comment)
                if let args = formatLoc.args {
                    str = String(format: formatLoc.format.localize(comment: formatLoc.comment), arguments: args)
                }
                self.setTitle(str, forSegmentAt: key)
            }
        }
    }
}
