# ByvLocalizations

[![CI Status](http://img.shields.io/travis/Pataluze/ByvLocalizations.svg?style=flat)](https://travis-ci.org/Pataluze/ByvLocalizations)
[![Version](https://img.shields.io/cocoapods/v/ByvLocalizations.svg?style=flat)](http://cocoapods.org/pods/ByvLocalizations)
[![License](https://img.shields.io/cocoapods/l/ByvLocalizations.svg?style=flat)](http://cocoapods.org/pods/ByvLocalizations)
[![Platform](https://img.shields.io/cocoapods/p/ByvLocalizations.svg?style=flat)](http://cocoapods.org/pods/ByvLocalizations)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ByvLocalizations is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ByvLocalizations"
```

## Usage

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.reloadLabels),
        name: ByvLocalizator.notiName,
        object: nil)

    reloadLabels()
}

@IBAction func change(_ sender: UIButton) {
    let av = UIAlertController(title: "Language".localize(comment: "Action sheet title"), message: "Select the language you want".localize(comment: "Action sheet description"), preferredStyle: .actionSheet)
    for language in ByvLocalizator.shared.availableLanguages {
        av.addAction(UIAlertAction(title: language.name(), style: .default, handler: { (action) in
            ByvLocalizator.shared.setLanguage(code: language.code)
        }))
    }
    av.addAction(UIAlertAction(title: "Cancel".localize(), style: .cancel, handler: nil))

    self.present(av, animated: true, completion: nil)
}

func reloadLabels() {
    label.text = "textToTranslate".localize()
    languageName.text = ByvLocalizator.shared.currentLanguage.name()
}
```

## Generator

This generator [ByvLocalizableStringsGenerator.swift](https://gist.github.com/adrianByv/4546b21df378c05b978375f446379754) can help to create and update Localizable.strings

## Author

Adrian Apodaca, adrian@byvapps.com

## License

ByvLocalizations is available under the MIT license. See the LICENSE file for more info.
