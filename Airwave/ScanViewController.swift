//
//  ScanViewController.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 23/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa
import CoreWLAN

class ScanViewController: NSViewController, WirelessUtilityDelegate {
    
    var utility : WirelessUtility! = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()

        //Create an utility instance
        self.utility = WirelessUtility(delegate: self)
        
        //Begin the scan
        self.utility.scan()
        
        
    }
    
    func onScanCompleted(networks: Networks) {
        
        DispatchQueue.main.sync {
            
            let vc : MainViewController = MainViewController();
            vc.networks = networks;
            
            
            self.presentViewController(vc, animator: SlideAnimator())
            
        }
        
        
    }
    
    func onError() {
        
    }
    
}
