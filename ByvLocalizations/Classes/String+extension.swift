//
//  String+extension.swift
//  ByvLocalizations
//
//  Created by Adrian Apodaca on 2/5/18.
//

import Foundation

public extension String {
    public func localize(comment:String? = nil) -> String {
        return ByvLocalizator.shared.localize(self, comment: comment)
    }
    
    public func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
}
