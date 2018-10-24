//
//  NetworkTableCell.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 12/08/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa

class NetworkTableCell: NSTableHeaderCell {


    override init(textCell: String)
    {
        super.init(textCell: textCell)
        // you can also set self.font = NSFont(...) here, too!
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(withFrame cellFrame: NSRect, in controlView: NSView)
    {
        super.draw(withFrame: cellFrame, in: controlView) // since that is what draws borders
        
        NSRectFill(cellFrame)
        self.drawInterior(withFrame: cellFrame, in: controlView)
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView)
    {
        let titleRect = self.titleRect(forBounds: cellFrame)
        self.attributedStringValue.draw(in: titleRect)
    }
    
}
