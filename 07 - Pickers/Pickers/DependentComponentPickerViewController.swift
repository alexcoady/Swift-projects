//
//  DependentComponentPickerViewController.swift
//  Pickers
//
//  Created by Alex Coady on 11/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dependentPicker: UIPickerView!
    
    private let stateComponent = 0
    private let zipComponent = 1
    
    private var stateZips: [String: [String]]!
    private var states: [String]!
    private var zips: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = NSBundle.mainBundle()
        let plistURL = bundle.URLForResource("statedictionary", withExtension: "plist")
        
        stateZips = NSDictionary(contentsOfURL: plistURL!) as [String: [String]]
        
        let allStates = stateZips.keys
        states = sorted(allStates)
        
        let selectedState = states[0]
        zips = stateZips[selectedState]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        let stateRow = dependentPicker.selectedRowInComponent(stateComponent)
        let zipRow = dependentPicker.selectedRowInComponent(zipComponent)
        
        let state = states[zipRow]
        let zip = zips[zipRow]
        
        let title = "You selected zip code \(zip)"
        let message = "\(zip) is in \(state)"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .Alert
        )
        
        let alertAction = UIAlertAction(
            title: "OK",
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
        
        if component == stateComponent {
            return states.count
        }
        
        return zips.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if component == stateComponent {
            
            return states[row]
        }
        
        return zips[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if ( component == stateComponent ) {
            
            let selectedState = states[row]
            zips = stateZips[selectedState]
            
            dependentPicker.reloadComponent(zipComponent)
            dependentPicker.selectRow(0, inComponent: zipComponent, animated: true)
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        let pickerWidth = pickerView.bounds.size.width
        
        if component == zipComponent {
            return pickerWidth / 3;
        }
        
        return (pickerWidth / 3) * 2
    }
}
