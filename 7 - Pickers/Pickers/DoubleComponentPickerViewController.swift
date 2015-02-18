//
//  DoubleComponentPickerViewController.swift
//  Pickers
//
//  Created by Alex Coady on 11/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var doublePicker: UIPickerView!
    private let fillingComponent = 0
    private let breadComponent = 1
    
    private let fillingTypes = [
        "Ham",
        "Turkey",
        "Peanut butter",
        "Tuna",
        "Chicken",
        "Roast beef",
        "Vegemite"
    ]
    
    private let breadTypes = [
        "White",
        "Whole wheat",
        "Rye",
        "Sourdough",
        "Seven grain"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonPressed(sender: AnyObject) {
        
        let fillingRow = doublePicker.selectedRowInComponent(fillingComponent)
        let breadRow = doublePicker.selectedRowInComponent(breadComponent)
        
        let filling = fillingTypes[fillingRow]
        let bread = breadTypes[breadRow]
        
        let message = "Your \(filling) on \(bread) will be right up"
        
        let alert = UIAlertController(
            title: "Thank you for your order",
            message: message,
            preferredStyle: .Alert
        )
        
        let alertAction = UIAlertAction(
            title: "Nice one",
            style: .Default,
            handler: nil
        )
        
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == breadComponent {
            return breadTypes.count
        }
        
        return fillingTypes.count
    }
    
    // MARK: Picker Delegate Methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if component == breadComponent {
            
            return breadTypes[row]
        }
        
        return fillingTypes[row]
    }
}
