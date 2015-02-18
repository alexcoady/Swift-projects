//
//  MasterViewController.swift
//  11 - Presidents
//
//  Created by Alex Coady on 16/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var presidents: [[String: String]]!

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("PresidentList", ofType: "plist")!
        let presidentInfo = NSDictionary(contentsOfFile: path)!
        
        presidents = presidentInfo["presidents"] as [NSDictionary] as [[String: String]]

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = presidents[indexPath.row]
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                
                if let oldController = detailViewController {
                    
                    // If current view is available, use its language string to preserve this
                    controller.languageString = oldController.languageString
                }
                
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                // Cache any old controller to store current language
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presidents.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let president = presidents[indexPath.row]
        
        cell.textLabel!.text = president["name"]
        
        return cell
    }
}

