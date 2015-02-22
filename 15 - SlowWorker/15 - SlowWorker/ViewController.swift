//
//  ViewController.swift
//  15 - SlowWorker
//
//  Created by Alex Coady on 18/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var resultsTextView: UITextView!
    @IBOutlet var spinner: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func fetchSomethingFromServer () -> String {
    
        NSThread.sleepForTimeInterval(1)
        return "Hi there"
    }
    
    
    func processData (data: String) -> String {
        
        NSThread.sleepForTimeInterval(2)
        return data.uppercaseString
    }
    
    
    func calculateFirstResult(data: String) -> String {
    
        NSThread.sleepForTimeInterval(3)
        return "Number of chars: \(countElements(data))"
    }
    
    
    func calculateSecondResult (data: String) -> String {
    
        NSThread.sleepForTimeInterval(4)
        return data.stringByReplacingOccurrencesOfString("E", withString: "e")
    }
    
    
    @IBAction func doWork(sender: AnyObject) {
    
        let startTime = NSDate()
        self.resultsTextView.text = ""
        self.startButton.enabled = false
        self.spinner.startAnimating()
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, {
            
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(fetchedData)
            let group = dispatch_group_create()
            
            var firstResult: String!
            var secondResult: String!
            
            dispatch_group_async(group, queue) {
                firstResult = self.calculateFirstResult(processedData)
            }
            
            dispatch_group_async(group, queue) {
                secondResult = self.calculateSecondResult(processedData)
            }
            
            dispatch_group_notify(group, queue) {
                let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.resultsTextView.text = resultsSummary
                    self.startButton.enabled = true
                    self.spinner.stopAnimating()
                })
                
                let endTime = NSDate()
                
                println("Completed in \(endTime.timeIntervalSinceDate(startTime)) seconds")
            }
        })
    }
}

