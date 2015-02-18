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
    private let rootKey = "rootKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = self.dataFilePath()
        
        if ( NSFileManager.defaultManager().fileExistsAtPath(filePath) ) {
            
            println("Populate from file: " + filePath)
            
            let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            
            let fourLines = unarchiver.decodeObjectForKey(rootKey) as FourLines
            unarchiver.finishDecoding()
            
            if let newLines = fourLines.lines {
                
                for var i = 0; i < newLines.count; i += 1 {
                    lineFields[i].text = newLines[i]
                }
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
        
        let fourLines = FourLines()
        let array = (self.lineFields as NSArray).valueForKey("text") as [String]
        
        fourLines.lines = array
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        archiver.encodeObject(fourLines, forKey: rootKey)
        archiver.finishEncoding()
        
        data.writeToFile(filePath, atomically: true)
    }

    
    // Return the string location of our file (and create it if it doesn't exist)
    func dataFilePath () -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        
        return documentsDirectory.stringByAppendingPathComponent("data.archive") as String
    }
}

