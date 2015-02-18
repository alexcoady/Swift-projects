//
//  ViewController.swift
//  13 - Persistence
//
//  Created by Alex Coady on 18/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = self.dataFilePath()
        
        if ( NSFileManager.defaultManager().fileExistsAtPath(filePath) ) {
            
            println("Populate from file: " + filePath)
            
            // Populate our text fields with saved content if the file exists
            let array = NSArray(contentsOfFile: filePath) as [String]
            for var i = 0; i < array.count; i += 1 {
                lineFields[i].text = array[i]
            }
        }
        
        // Listen to the "UIApplicationWillResignActiveNotification" of app and trigger "applicationWillResignActive" method of self (this class)
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Push contents of text fields to plist file when the application will resign active state
    func applicationWillResignActive ( notification: NSNotification ) {
        
        let filePath = self.dataFilePath()
        let array = ( self.lineFields as NSArray ).valueForKey("text") as NSArray
        
        array.writeToFile(filePath, atomically: true)
    }

    
    // Return the string location of our file (and create it if it doesn't exist)
    func dataFilePath () -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        
        return documentsDirectory.stringByAppendingPathComponent("data.plist") as String
    }
}

