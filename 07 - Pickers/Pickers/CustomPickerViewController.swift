//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by Alex Coady on 11/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    private var images: [UIImage]!
    private var winSoundId: SystemSoundID = 0
    private var crunchSoundId: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "crown")!,
            UIImage(named: "cherry")!,
            UIImage(named: "lemon")!,
            UIImage(named: "apple")!
        ]
        
        winLabel.text = " "
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showButton () {
        button.hidden = false
    }
    
    func playWinSound () {
        
        // Generate a sound ID if one doesn't already exist // lazy loading
        if winSoundId == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("win", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &winSoundId)
        }
        
        AudioServicesPlaySystemSound(winSoundId)
        winLabel.text = "WINNER!"
        
        showButton()
    }
    
    func playCrunchSound () {
        
        if crunchSoundId == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("crunch", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundId)
        }
        
        AudioServicesPlaySystemSound(crunchSoundId)
    }
    
    @IBAction func spin(sender: AnyObject) {
        
        var win = false
        var numInRow = -1
        var lastVal = -1
        
        for i in 0..<5 {
                        
            // Gets a random index of an image (0..images.count)
            let newValue = Int( arc4random_uniform(UInt32(images.count)) )
            
            if newValue == lastVal {
                numInRow++
            } else {
                numInRow = 1
            }
            lastVal = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            
            picker.reloadComponent(i)
            
            if numInRow >= 3 {
                win = true
            }
        }
        
        playCrunchSound()
        
        dispatch_after( dispatch_time( DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            
            if win { self.playWinSound() } else { self.showButton() }
        }
        
        button.hidden = true
        winLabel.text = " "
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return images.count
    }
    
    // MARK:-
    // MARK: Picker Delegate Methods
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 64
    }
}
