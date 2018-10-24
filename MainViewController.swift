//
//  MainViewController.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 23/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    public var networks : Networks = nil
    
    @IBOutlet weak var natworkTableView: NetworkTable!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do view setup here.
        
        self.natworkTableView.setData(networks: self.networks)
        
    }
    
    
    
    
}
