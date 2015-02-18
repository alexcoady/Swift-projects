//
//  ViewController.swift
//  13 - Core Data Persistence
//
//  Created by Alex Coady on 18/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    // Outlets
    @IBOutlet var lineFields: [UITextField]!
    
    
    // Private constants
    private let lineEntityName = "Line"
    private let lineNumberKey = "lineNumber"
    private let lineTextKey = "lineText"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: lineEntityName)
        
        var error: NSError? = nil
        let objects = context?.executeFetchRequest(request, error: &error)
        
        if let objectList = objects {
            
            for oneObject in objectList {
                
                let lineNum = oneObject.valueForKey(lineNumberKey)!.integerValue
                let lineText = oneObject.valueForKey(lineTextKey) as String
                let textField = lineFields[lineNum]
                textField.text = lineText
            }
        
        } else {
        
            println("There was an error")
            // Do some error handling
        }
        
        let app = UIApplication.sharedApplication()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }
    
    
    func applicationWillResignActive ( notification: NSNotification ) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        var error: NSError? = nil
        
        for var i = 0; i < lineFields?.count; i += 1 {
            
            let textField = lineFields[i]
            let request = NSFetchRequest(entityName: lineEntityName)
            let pred = NSPredicate(format: "%K = %d", lineNumberKey, i)
            request.predicate = pred

            let objects = context?.executeFetchRequest(request, error: &error)
            
            if let objectList = objects {
                
                var theLine: NSManagedObject! = nil
                if objectList.count > 0 {
                    
                    theLine = objectList[0] as NSManagedObject
                
                } else {
                    
                    theLine = NSEntityDescription.insertNewObjectForEntityForName(lineEntityName, inManagedObjectContext: context!) as NSManagedObject
                }
                
                theLine.setValue(i, forKey: lineNumberKey)
                theLine.setValue(textField.text, forKey: lineTextKey)
            
            } else {
                
                println("There was en error")
            }
        }
        
        appDelegate.saveContext()
    }
}

