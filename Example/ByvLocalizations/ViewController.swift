//
//  ViewController.swift
//  ByvLocalizations
//
//  Created by Pataluze on 04/28/2017.
//  Copyright (c) 2017 Pataluze. All rights reserved.
//

import UIKit
import ByvLocalizations

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadLabels),
            name: ByvLocalizator.notiName,
            object: nil)
        
        
        self.navigationController?.tabBarItem.locTitle("textToTranslate1")
        self.navigationController?.tabBarItem.locTitle("textToTranslate")
        
        self.navigationItem.locTitle("textToTranslate2")
        self.navigationItem.locTitle("textToTranslate")
        
        barButton.locTitle("textToTranslate3")
        barButton.locTitle("textToTranslate")
        
        searchBar.locPlaceholder("textToTranslate4")
        searchBar.locPlaceholder("textToTranslate")
        
        textField.locPlaceholder("textToTranslate5")
        textField.locPlaceholder("textToTranslate")
        
        segmented.locTitle("first", at: 0)
        segmented.locTitle("second", at: 1)
        
        textView.locText("textToTranslate6", comment: "The comment")
        textView.locText("textToTranslate")
        
        label.locText("formatText", args: [22.586], comment: "%.2f is points value")
        
        changeBtn.locTitle("changeText")
        
        // to test genstring
        _ = NSLocalizedString("NSLocalizedString", comment: "comment")
        if let path = Bundle.main.path(forResource: "Base", ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                _ = NSLocalizedString("NSLocalizedString_full", tableName: nil, bundle: bundle, value: "", comment: "comentario")
            }
        }
        
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
    
    @objc func reloadLabels() {
        languageName.text = ByvLocalizator.shared.currentLanguage.name()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

