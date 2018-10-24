//
//  WindowController.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 21/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        
        self.window!.backgroundColor = NSColor(red:34/255.0, green:34/255.0, blue:34/255.0, alpha: 1)
        self.window!.titlebarAppearsTransparent = true
        
    }
    
}
