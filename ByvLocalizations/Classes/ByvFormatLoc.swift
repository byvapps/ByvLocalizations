//
//  ByvFormatLoc.swift
//  ByvLocalizationsUIExtensions
//
//  Created by Adrian Apodaca on 1/5/18.
//

import UIKit

class ByvFormatLoc : NSObject {
    static var assKey: UInt8 = 0
    
    var format: String!
    var args: [CVarArg]? = nil
    
    required init(format: String, args:[CVarArg]? = nil) {
        super.init()
        self.format = format
        self.args = args
    }
}
