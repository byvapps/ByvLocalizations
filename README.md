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

    // This label will reload automatically when language change
    autoLabel.locText("Localized_key")

    // suport format strings with arguments to update localized text correctly
    format.locText("%.2f POINTS", args: [22.586], comment: "%.2f is points value")

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

## Extensions

Now implements some UI extensions to make more easy localizations. They are automatically updated en language change

```swift
UILabel             =>  label.locText("localized_text")

UITextView          =>  textView.locText("localized_text")

UIButton            =>  button.locTitle("localized_text")

UITabBarItem        =>  self.navigationController?.tabBarItem.locTitle("localized_text")

UINavigationItem    =>  sself.navigationItem.locTitle("localized_text")

UIBarButtonItem     =>  barButton.locTitle("localized_text")

UITextField         =>  textField.locPlaceholder("localized_text")

UISearchBar         =>  searchBar.locPlaceholder("localized_text")

UISegmentedControl  =>  segmented.locTitle("first", at: 0)
                        segmented.locTitle("second", at: 1)
```


## Generator

This generator [ByvLocalizableStringsGenerator](https://github.com/byvapps/ByvLocalizableStringsGenerator) can help to create and update Localizable.strings

## Interface Builder Extensions

If you want to localize texts directly from Interface builder you can use [ByvLocalizationsIB](https://github.com/byvapps/ByvLocalizationsIB)

```ruby
pod "ByvLocalizationsIB"
```

## Author

Adrian Apodaca, adrian@byvapps.com

## License

ByvLocalizations is available under the MIT license. See the LICENSE file for more info.
