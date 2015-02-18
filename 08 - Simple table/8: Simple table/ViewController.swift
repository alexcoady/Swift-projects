//
//  ViewController.swift
//  8: Simple table
//
//  Created by Alex Coady on 13/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let dwarves = ["Sleepy", "Sneezy", "Bashful", "Happy", "Doc", "Grumpy", "Dopey", "Thorin", "Dorin", "Nori", "Ori", "Balin", "Dwalin", "Fili", "Kili", "Oin", "Gloin", "Bifur", "Bofur", "Bombur"]
    
    let simpleTableIdentifer = "SimpleTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dwarves.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifer) as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: .Value1,
                reuseIdentifier: simpleTableIdentifer
            )
        }
        
        // Row images
        cell!.imageView?.image = UIImage(named: "star")
        cell!.imageView?.highlightedImage = UIImage(named: "star2")
        
        
        // Row labels
        cell!.textLabel?.text = dwarves[indexPath.row]
        cell!.textLabel?.font = UIFont.boldSystemFontOfSize(50)
        cell!.detailTextLabel?.text = indexPath.row < 7 ? "Mr Disney" : "Mr Tolkien"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        
        return indexPath.row % 4
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        if ( indexPath.row == 0 ) {
            return nil
        }
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowValue = dwarves[indexPath.row]
        let message = "You selected \(rowValue)"
        
        let controller = UIAlertController(
            title: "Row selected",
            message: message,
            preferredStyle: .Alert
        )
        
        let alertAction = UIAlertAction(
            title: "Aye lad",
            style: .Default,
            handler: nil
        )
        
        controller.addAction(alertAction)
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return indexPath.row == 0 ? 120 : 70
    }
}

