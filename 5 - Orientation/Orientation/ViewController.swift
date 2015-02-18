//
//  ViewController.swift
//  Orientation
//
//  Created by Alex Coady on 10/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Allows Portrait and Landscape orientations to be used for THIS view
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
            | Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
        
        // Other orientations include specifics like:
        // - PortraitUpsideDown
        // - LandscapeLeft
        // - LandscapeRight
        //
        // and aliases like:
        // - Landscape (left and right)
        // - All
        // - AllButUpsideDown
        
        
    }
}

