//
//  ByvFormatLoc.swift
//  ByvLocalizationsUIExtensions
//
//  Created by Adrian Apodaca on 1/5/18.
//

import UIKit

public class ByvFormatLoc : NSObject {
    static var assKey: UInt8 = 0
    
    public var format: String!
    public var args: [CVarArg]? = nil
    public var comment: String? = nil
    
    public required init(format: String, args:[CVarArg]? = nil, comment: String? = nil) {
        super.init()
        self.format = format
        self.args = args
    }
}
