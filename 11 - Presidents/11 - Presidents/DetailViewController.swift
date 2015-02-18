//
//  DetailViewController.swift
//  11 - Presidents
//
//  Created by Alex Coady on 16/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    private var languageButton: UIBarButtonItem?
    private var languagePopoverController: UIPopoverController?
    
    var languageString: String = "" {
        didSet {
            if (languageString != oldValue) {
                configureView()
            }
            
            if let popoverController = languagePopoverController {
                
                popoverController.dismissPopoverAnimated(true)
                languagePopoverController = nil
            }
        }
    }

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        
        if let detail: AnyObject = self.detailItem {
            
            if let label = self.detailDescriptionLabel {
                
                let dict = detail as [String: String]
                let urlString = modifyURLForLanguage(url: dict["url"]!, language: languageString)
                label.text = urlString
                
                let url = NSURL(string: urlString)!
                let request = NSURLRequest(URL: url)
                webView.loadRequest(request)
                
                let name = dict["name"]!
                title = name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        
            languageButton = UIBarButtonItem(title: "Choose language", style: .Plain, target: self, action: "toggleLanguagePopover")
            navigationItem.rightBarButtonItem = languageButton
        }

        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func modifyURLForLanguage(#url: String, language lang: String?) -> String {
        
        var newUrl = url
        
        if let langStr = lang {
            
            let range = NSMakeRange(7, 2)
            
            if ( !langStr.isEmpty && (url as NSString).substringWithRange(range) != langStr ) {
            
                newUrl = (url as NSString).stringByReplacingCharactersInRange(range, withString: langStr)
            }
        }
        
        return newUrl
    }
    
    func toggleLanguagePopover () {
        
        if languagePopoverController == nil {
            
            let languageListController = LanguageListController()
            languageListController.detailViewController = self
            
            languagePopoverController = UIPopoverController(contentViewController: languageListController)
            languagePopoverController?.presentPopoverFromBarButtonItem(languageButton!, permittedArrowDirections: .Any, animated: true)
        
        } else {
            
            languagePopoverController?.dismissPopoverAnimated(true)
            languagePopoverController = nil
        }
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        
        if popoverController == languagePopoverController {
            
            languagePopoverController = nil
        }
    }
}

