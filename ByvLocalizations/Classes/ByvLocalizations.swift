//
//  ByvLocalizations.swift
//  Pods
//
//  Created by Adrian Apodaca on 28/4/17.
//
//

import Foundation


public struct Language {
    public var code:String
    
    public func name() -> String {
        let loc = Locale(identifier: self.code)
        return loc.localizedString(forLanguageCode: self.code)?.capitalizingFirstLetter() ?? self.code
    }
    
    public func languageCode() -> String {
        let loc = Locale(identifier: self.code)
        return loc.languageCode ?? self.code
    }
    
    public func nameInMyLocale() -> String {
        return Locale.current.localizedString(forLanguageCode: self.code) ?? self.code
    }
}

public class ByvLocalizator {
    
    static public let notiName = Notification.Name("ByvLanguageDidChange")
    
    static public let shared = ByvLocalizator()
    var baseCode:String = "Base"
    
    lazy var bundle:Bundle = {
        if let path = Bundle.main.path(forResource: self.currentLanguage.code, ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                return bundle
            }
        } else if let path = Bundle.main.path(forResource: "Base", ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                return bundle
            }
        }
        fatalError("Localizable file NOT found")
    }()
    
    public lazy var currentLanguage:Language! = {
        if let lang = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as? String {
            let loc = Locale(identifier: lang)
            for language in self.availableLanguages {
                if loc.languageCode == language.languageCode() {
                    return language
                }
            }
        }
        return Language(code: self.baseCode)
    }()
    
    public func setLanguage(code: String) {
        for lang in self.availableLanguages {
            if lang.code == code {
                UserDefaults.standard.set([code], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                currentLanguage = Language(code: code)
                if let path = Bundle.main.path(forResource: self.currentLanguage.code, ofType: "lproj") {
                    if let _bundle = Bundle(path: path) {
                        self.bundle = _bundle
                    }
                }
                NotificationCenter.default.post(name: ByvLocalizator.notiName, object: nil)
                return
            }
        }
    }
    
    public lazy var availableLanguages:[Language] = {
        var response:[Language] = []
        for code in Bundle.main.localizations {
            if code != self.baseCode {
                response.append(Language(code: code))
            }
        }
        return response
    }()
    
    public func localize(_ string:String, comment:String) -> String {
        return NSLocalizedString(string, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

public extension String {
    public func localize(comment:String = "") -> String {
        return ByvLocalizator.shared.localize(self, comment: comment)
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
}
