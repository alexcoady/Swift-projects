//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by Alex Coady on 11/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = NSDate()
        datePicker.setDate( date, animated: false )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        let date = datePicker.date
        let message = "You picked this date \(date)"
        
        let alert = UIAlertController(
            title: "Date and time selected",
            message: message,
            preferredStyle: .Alert
        )
        
        let actionOK = UIAlertAction(
            title: "Nice one",
            style: .Default,
            handler: nil
        )
        
        alert.addAction(actionOK)
        presentViewController(alert, animated: true, completion: nil)
    }
}
