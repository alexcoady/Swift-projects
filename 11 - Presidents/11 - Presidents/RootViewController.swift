//
//  RootViewController.swift
//  11 - Presidents
//
//  Created by Alex Coady on 17/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        
        let splitVC = viewControllers[0] as UIViewController
        let newTraits = traitCollection
        
        // Override the compact x compact size ( iPhone in landscape orientation )
        if newTraits.horizontalSizeClass == .Compact && newTraits.verticalSizeClass == .Compact {
        
            let childTraits = UITraitCollection(horizontalSizeClass: .Regular)
            setOverrideTraitCollection(childTraits, forChildViewController: splitVC)
        
        } else {
        
            setOverrideTraitCollection(nil, forChildViewController: splitVC)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
